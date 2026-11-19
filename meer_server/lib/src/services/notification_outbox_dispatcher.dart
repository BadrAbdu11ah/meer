import 'dart:async';

import 'package:meer_server/src/generated/protocol.dart';
import 'package:meer_server/src/services/fcm_service.dart';
import 'package:serverpod/serverpod.dart';

/// Delivery states of a [NotificationOutbox] record.
abstract final class NotificationOutboxStatus {
  static const pending = 'pending';
  static const processing = 'processing';
  static const sent = 'sent';
  static const failed = 'failed';
}

/// Sends one outbox record to its device installation.
///
/// Throws when the notification was not accepted.
typedef OutboxNotificationSender =
    Future<void> Function(NotificationOutbox notification);

/// One FCM client for the whole server, so its OAuth client is reused between
/// dispatcher runs.
final FcmService _fcmService = FcmService();

Future<void> _sendWithFcm(NotificationOutbox notification) async {
  await _fcmService.sendToInstallation(
    installationId: notification.installationId,
    title: notification.title,
    body: notification.body,
    data: notification.data,
  );
}

/// Delivers due [NotificationOutbox] records through FCM.
///
/// Delivery is at-least-once, not exactly-once: if the server stops after FCM
/// accepted a notification but before the record was marked as sent, the
/// record is recovered when its lock lease expires and sent again.
class NotificationOutboxDispatcher {
  NotificationOutboxDispatcher({
    OutboxNotificationSender? sender,
    DateTime Function()? clock,
  }) : _send = sender ?? _sendWithFcm,
       _clock = clock ?? _utcNow;

  /// Records claimed by one transaction.
  static const batchSize = 20;

  /// Upper bound of batches per run, so one run cannot go on forever.
  static const maxBatchesPerRun = 5;

  /// Number of sends, including the first one, before a record is failed.
  static const maxAttempts = 8;

  static const initialRetryDelay = Duration(seconds: 15);
  static const maxRetryDelay = Duration(minutes: 30);

  /// A send that takes longer than this counts as a temporary failure.
  static const sendTimeout = Duration(seconds: 30);

  /// How long a record may stay `processing` before another run takes it over.
  /// Must be longer than [sendTimeout].
  static const lockLease = Duration(minutes: 2);

  static const _maxErrorLength = 500;

  final OutboxNotificationSender _send;
  final DateTime Function() _clock;

  static DateTime _utcNow() => DateTime.now().toUtc();

  /// Claims and delivers due records, and returns how many were claimed.
  Future<int> dispatchDueNotifications(Session session) async {
    var claimedCount = 0;

    for (var batch = 0; batch < maxBatchesPerRun; batch++) {
      final claimed = await claimDueNotifications(session);

      // No transaction is open while FCM is called.
      await Future.wait(
        claimed.map((notification) => _deliver(session, notification)),
      );

      claimedCount += claimed.length;

      if (claimed.length < batchSize) break;
    }

    return claimedCount;
  }

  /// Marks up to [batchSize] due records as `processing` and returns them.
  ///
  /// Due records are `pending` ones whose retry time has arrived, and
  /// `processing` ones whose lock is older than [lockLease]. Rows locked by
  /// another dispatcher are skipped, so a record is never claimed twice.
  Future<List<NotificationOutbox>> claimDueNotifications(
    Session session,
  ) async {
    final now = _clock();
    final leaseExpiredBefore = now.subtract(lockLease);

    return session.db.transaction((transaction) async {
      final due = await NotificationOutbox.db.find(
        session,
        where: (t) =>
            (t.status.equals(NotificationOutboxStatus.pending) &
                (t.nextAttemptAt <= now)) |
            (t.status.equals(NotificationOutboxStatus.processing) &
                (t.lockedAt < leaseExpiredBefore)),
        orderBy: (t) => t.nextAttemptAt,
        limit: batchSize,
        lockMode: LockMode.forUpdate,
        lockBehavior: LockBehavior.skipLocked,
        transaction: transaction,
      );

      final claimed = <NotificationOutbox>[];
      final exhausted = <NotificationOutbox>[];

      for (final notification in due) {
        if (notification.attemptCount >= maxAttempts) {
          // Only a record whose last attempt never finished gets here.
          exhausted.add(
            notification
              ..status = NotificationOutboxStatus.failed
              ..lockedAt = null
              ..lastError = 'The final attempt did not finish.',
          );
        } else {
          claimed.add(
            notification
              ..status = NotificationOutboxStatus.processing
              ..lockedAt = now
              ..attemptCount = notification.attemptCount + 1,
          );
        }
      }

      if (exhausted.isNotEmpty) {
        await NotificationOutbox.db.update(
          session,
          exhausted,
          columns: (t) => [t.status, t.lockedAt, t.lastError],
          transaction: transaction,
        );
      }

      if (claimed.isEmpty) return claimed;

      return NotificationOutbox.db.update(
        session,
        claimed,
        columns: (t) => [t.status, t.lockedAt, t.attemptCount],
        transaction: transaction,
      );
    });
  }

  /// The delay before the retry that follows failed attempt [attemptCount]:
  /// 15s, 30s, 1m, ... capped at [maxRetryDelay].
  static Duration retryDelay(int attemptCount) {
    final doublings = (attemptCount - 1).clamp(0, 30);
    final delay = initialRetryDelay * (1 << doublings);

    return delay > maxRetryDelay ? maxRetryDelay : delay;
  }

  Future<void> _deliver(
    Session session,
    NotificationOutbox notification,
  ) async {
    try {
      await _send(notification).timeout(sendTimeout);
    } on FcmSendException catch (error) {
      if (error.isUnregistered) {
        await _failInvalidInstallation(session, notification, error);
      } else {
        await _retryOrFail(session, notification, error);
      }
      return;
    } catch (error) {
      // Network, timeout and Google authentication errors are temporary.
      await _retryOrFail(session, notification, error);
      return;
    }

    await _markSent(session, notification);
  }

  Future<void> _markSent(
    Session session,
    NotificationOutbox notification,
  ) async {
    await _finish(
      session,
      notification,
      columnValues: (t) => [
        t.status(NotificationOutboxStatus.sent),
        t.sentAt(_clock()),
        t.lockedAt(null),
        t.lastError(null),
      ],
    );
  }

  Future<void> _retryOrFail(
    Session session,
    NotificationOutbox notification,
    Object error,
  ) async {
    final description = _describe(error);
    final isLastAttempt = notification.attemptCount >= maxAttempts;

    session.log(
      'Notification outbox ${notification.id} '
      '(${notification.event}, order ${notification.orderId}) failed on '
      'attempt ${notification.attemptCount}/$maxAttempts: $description',
      level: isLastAttempt ? LogLevel.error : LogLevel.warning,
    );

    if (isLastAttempt) {
      await _finish(
        session,
        notification,
        columnValues: (t) => [
          t.status(NotificationOutboxStatus.failed),
          t.lockedAt(null),
          t.lastError(description),
        ],
      );
      return;
    }

    await _finish(
      session,
      notification,
      columnValues: (t) => [
        t.status(NotificationOutboxStatus.pending),
        t.nextAttemptAt(_clock().add(retryDelay(notification.attemptCount))),
        t.lockedAt(null),
        t.lastError(description),
      ],
    );
  }

  /// Fails the record for good and removes the installation Firebase no
  /// longer knows.
  Future<void> _failInvalidInstallation(
    Session session,
    NotificationOutbox notification,
    FcmSendException error,
  ) async {
    session.log(
      'Notification outbox ${notification.id}: Firebase reports the device '
      'installation as unregistered; removing it.',
      level: LogLevel.warning,
    );

    await session.db.transaction((transaction) async {
      final markedAsFailed = await _finish(
        session,
        notification,
        columnValues: (t) => [
          t.status(NotificationOutboxStatus.failed),
          t.lockedAt(null),
          t.lastError(_describe(error)),
        ],
        transaction: transaction,
      );

      if (!markedAsFailed) return;

      await UserDeviceInstallation.db.deleteWhere(
        session,
        where: (t) => t.installationId.equals(notification.installationId),
        transaction: transaction,
      );
    });
  }

  /// Writes the outcome of an attempt, unless the claim was lost.
  ///
  /// A claim is lost when the send outlived [lockLease] and another run took
  /// the record over. That run has raised `attemptCount`, so the outcome of
  /// this attempt must not overwrite its state.
  Future<bool> _finish(
    Session session,
    NotificationOutbox notification, {
    required ColumnValueListBuilder<NotificationOutboxUpdateTable> columnValues,
    Transaction? transaction,
  }) async {
    final updated = await NotificationOutbox.db.updateWhere(
      session,
      columnValues: columnValues,
      where: (t) =>
          t.id.equals(notification.id) &
          t.status.equals(NotificationOutboxStatus.processing) &
          t.attemptCount.equals(notification.attemptCount),
      transaction: transaction,
    );

    if (updated.isEmpty) {
      session.log(
        'Notification outbox ${notification.id} was taken over by another '
        'dispatcher; its attempt ${notification.attemptCount} is ignored.',
        level: LogLevel.warning,
      );

      return false;
    }

    return true;
  }

  static String _describe(Object error) {
    final description = error.toString();

    return description.length <= _maxErrorLength
        ? description
        : description.substring(0, _maxErrorLength);
  }
}
