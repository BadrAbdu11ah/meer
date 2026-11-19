import 'dart:async';
import 'dart:io';

import 'package:meer_server/src/generated/protocol.dart';
import 'package:meer_server/src/services/fcm_service.dart';
import 'package:meer_server/src/services/notification_outbox_dispatcher.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

/// Stands in for FCM: records every send and fails when told to.
class _FakeSender {
  final sent = <NotificationOutbox>[];

  /// Thrown by every send while set.
  Object? failure;

  Future<void> call(NotificationOutbox notification) async {
    sent.add(notification);

    final failure = this.failure;
    if (failure != null) throw failure;
  }

  List<String> get installationIds => [
    for (final notification in sent) notification.installationId,
  ];
}

const _unregistered = FcmSendException(
  statusCode: 404,
  status: 'UNREGISTERED',
  message: 'Requested entity was not found.',
);

const _unavailable = FcmSendException(
  statusCode: 503,
  status: 'UNAVAILABLE',
  message: 'The service is currently unavailable.',
);

void main() {
  test('retry delay doubles from 15 seconds and is capped at 30 minutes', () {
    Duration delay(int attempt) =>
        NotificationOutboxDispatcher.retryDelay(attempt);

    expect(delay(1), const Duration(seconds: 15));
    expect(delay(2), const Duration(seconds: 30));
    expect(delay(3), const Duration(minutes: 1));
    expect(delay(7), const Duration(minutes: 16));
    expect(delay(8), const Duration(minutes: 30));
    expect(delay(60), const Duration(minutes: 30));
  });

  withServerpod(
    'Given a notification outbox',
    (sessionBuilder, endpoints) {
      late Session session;
      late _FakeSender sender;
      late DateTime now;
      late NotificationOutboxDispatcher dispatcher;
      final authUserIds = <UuidValue>[];

      Future<NotificationOutbox> enqueue(
        String installationId, {
        String status = NotificationOutboxStatus.pending,
        int attemptCount = 0,
        DateTime? nextAttemptAt,
        DateTime? lockedAt,
      }) {
        return NotificationOutbox.db.insertRow(
          session,
          NotificationOutbox(
            recipientProfileId: 1,
            installationId: installationId,
            orderId: 7,
            event: 'new_order',
            title: 'طلب جديد #7',
            body: 'وصلك طلب جديد من العميل عميل الاختبار.',
            data: {
              'type': 'order',
              'event': 'new_order',
              'orderId': '7',
              'actorName': 'عميل الاختبار',
            },
            status: status,
            attemptCount: attemptCount,
            nextAttemptAt: nextAttemptAt ?? now,
            lockedAt: lockedAt,
            createdAt: now,
            dedupeKey: '7:new_order:$installationId',
          ),
        );
      }

      Future<NotificationOutbox> reload(NotificationOutbox notification) async {
        final row = await NotificationOutbox.db.findById(
          session,
          notification.id!,
        );
        return row!;
      }

      Future<void> registerDevice(String installationId) async {
        final authUser = await const AuthUsers().create(session);
        authUserIds.add(authUser.id);

        await UserDeviceInstallation.db.insertRow(
          session,
          UserDeviceInstallation(
            authUserId: authUser.id,
            installationId: installationId,
            platform: 'android',
          ),
        );
      }

      Future<List<String>> registeredDevices() async {
        final installations = await UserDeviceInstallation.db.find(session);
        return [for (final i in installations) i.installationId];
      }

      setUp(() {
        session = sessionBuilder.build();
        sender = _FakeSender();
        // قاعدة البيانات تحفظ الوقت بدقة الميكروثانية وبتوقيت UTC.
        now = DateTime.utc(2026, 11, 19, 12);
        dispatcher = NotificationOutboxDispatcher(
          sender: sender.call,
          clock: () => now,
        );
      });

      // هذه الاختبارات تحتاج Transactions حقيقية، فالتنظيف يدوي.
      tearDown(() async {
        await NotificationOutbox.db.deleteWhere(
          session,
          where: (t) => Constant.bool(true),
        );

        for (final authUserId in authUserIds) {
          await const AuthUsers().delete(session, authUserId: authUserId);
        }
        authUserIds.clear();
      });

      test(
        'when FCM accepts a record then it is marked as sent',
        () async {
          final record = await enqueue('device-1');

          final claimedCount = await dispatcher.dispatchDueNotifications(
            session,
          );

          final stored = await reload(record);

          expect(claimedCount, 1);
          expect(stored.status, NotificationOutboxStatus.sent);
          expect(stored.sentAt, now);
          expect(stored.lockedAt, isNull);
          expect(stored.lastError, isNull);
          expect(stored.attemptCount, 1);

          expect(sender.sent.single.installationId, 'device-1');
          expect(sender.sent.single.title, 'طلب جديد #7');
          expect(
            sender.sent.single.body,
            'وصلك طلب جديد من العميل عميل الاختبار.',
          );
          expect(sender.sent.single.data, {
            'type': 'order',
            'event': 'new_order',
            'orderId': '7',
            'actorName': 'عميل الاختبار',
          });
        },
      );

      test(
        'when a sent record is seen again then it is not sent twice',
        () async {
          await enqueue('device-1');

          await dispatcher.dispatchDueNotifications(session);
          now = now.add(const Duration(hours: 1));
          final claimedCount = await dispatcher.dispatchDueNotifications(
            session,
          );

          expect(claimedCount, 0);
          expect(sender.sent, hasLength(1));
        },
      );

      test(
        'when a record is not due yet then it is left alone',
        () async {
          final record = await enqueue(
            'device-1',
            nextAttemptAt: now.add(const Duration(seconds: 1)),
          );

          await dispatcher.dispatchDueNotifications(session);

          expect(sender.sent, isEmpty);
          expect((await reload(record)).status, 'pending');
          expect((await reload(record)).attemptCount, 0);
        },
      );

      test(
        'when a send fails temporarily then the record is retried with backoff',
        () async {
          final record = await enqueue('device-1');
          sender.failure = const SocketException('Connection reset');

          await dispatcher.dispatchDueNotifications(session);

          var stored = await reload(record);

          expect(stored.status, NotificationOutboxStatus.pending);
          expect(stored.attemptCount, 1);
          expect(stored.nextAttemptAt, now.add(const Duration(seconds: 15)));
          expect(stored.lockedAt, isNull);
          expect(stored.sentAt, isNull);
          expect(stored.lastError, contains('Connection reset'));

          // قبل موعد المحاولة التالية لا يعاد الإرسال.
          now = now.add(const Duration(seconds: 14));
          await dispatcher.dispatchDueNotifications(session);
          expect(sender.sent, hasLength(1));

          now = now.add(const Duration(seconds: 1));
          await dispatcher.dispatchDueNotifications(session);

          stored = await reload(record);

          expect(sender.sent, hasLength(2));
          expect(stored.attemptCount, 2);
          expect(stored.nextAttemptAt, now.add(const Duration(seconds: 30)));
        },
      );

      test(
        'when a retry succeeds then the previous error is cleared',
        () async {
          final record = await enqueue('device-1');
          sender.failure = _unavailable;
          await dispatcher.dispatchDueNotifications(session);

          sender.failure = null;
          now = now.add(const Duration(seconds: 15));
          await dispatcher.dispatchDueNotifications(session);

          final stored = await reload(record);

          expect(stored.status, NotificationOutboxStatus.sent);
          expect(stored.attemptCount, 2);
          expect(stored.lastError, isNull);
          expect(stored.sentAt, now);
        },
      );

      test(
        'when FCM is unavailable then the installation is kept for the retry',
        () async {
          await registerDevice('device-1');
          final record = await enqueue('device-1');
          sender.failure = _unavailable;

          await dispatcher.dispatchDueNotifications(session);

          final stored = await reload(record);

          expect(stored.status, NotificationOutboxStatus.pending);
          expect(stored.lastError, contains('UNAVAILABLE'));
          expect(await registeredDevices(), ['device-1']);
        },
      );

      test(
        'when every attempt fails then the record is failed after the last one',
        () async {
          final record = await enqueue('device-1');
          sender.failure = TimeoutException('FCM did not answer');

          for (
            var attempt = 1;
            attempt <= NotificationOutboxDispatcher.maxAttempts;
            attempt++
          ) {
            await dispatcher.dispatchDueNotifications(session);
            now = now.add(NotificationOutboxDispatcher.maxRetryDelay);
          }

          final stored = await reload(record);

          expect(stored.status, NotificationOutboxStatus.failed);
          expect(stored.attemptCount, NotificationOutboxDispatcher.maxAttempts);
          expect(stored.lockedAt, isNull);
          expect(stored.lastError, contains('FCM did not answer'));

          await dispatcher.dispatchDueNotifications(session);

          expect(
            sender.sent,
            hasLength(NotificationOutboxDispatcher.maxAttempts),
          );
        },
      );

      test(
        'when the installation is unregistered then it is removed and never retried',
        () async {
          await registerDevice('stale-device');
          await registerDevice('other-device');
          final record = await enqueue('stale-device');
          sender.failure = _unregistered;

          await dispatcher.dispatchDueNotifications(session);

          final stored = await reload(record);

          expect(stored.status, NotificationOutboxStatus.failed);
          expect(stored.attemptCount, 1);
          expect(stored.lockedAt, isNull);
          expect(stored.lastError, contains('UNREGISTERED'));
          expect(await registeredDevices(), ['other-device']);

          now = now.add(const Duration(days: 1));
          await dispatcher.dispatchDueNotifications(session);

          expect(sender.sent, hasLength(1));
        },
      );

      test(
        'when a processing lock has expired then the record is recovered',
        () async {
          final abandoned = await enqueue(
            'crashed-device',
            status: NotificationOutboxStatus.processing,
            attemptCount: 1,
            lockedAt: now.subtract(
              NotificationOutboxDispatcher.lockLease +
                  const Duration(seconds: 1),
            ),
          );
          final inFlight = await enqueue(
            'busy-device',
            status: NotificationOutboxStatus.processing,
            attemptCount: 1,
            lockedAt: now.subtract(const Duration(seconds: 30)),
          );

          await dispatcher.dispatchDueNotifications(session);

          final recovered = await reload(abandoned);

          expect(sender.installationIds, ['crashed-device']);
          expect(recovered.status, NotificationOutboxStatus.sent);
          expect(recovered.attemptCount, 2);
          expect(
            (await reload(inFlight)).status,
            NotificationOutboxStatus.processing,
          );
        },
      );

      test(
        'when the final attempt never finished then the record is failed unsent',
        () async {
          final record = await enqueue(
            'crashed-device',
            status: NotificationOutboxStatus.processing,
            attemptCount: NotificationOutboxDispatcher.maxAttempts,
            lockedAt: now.subtract(const Duration(hours: 1)),
          );

          await dispatcher.dispatchDueNotifications(session);

          final stored = await reload(record);

          expect(sender.sent, isEmpty);
          expect(stored.status, NotificationOutboxStatus.failed);
          expect(stored.lockedAt, isNull);
          expect(stored.lastError, isNotNull);
        },
      );

      test(
        'when claiming then the record is locked before anything is sent',
        () async {
          final record = await enqueue('device-1');

          final claimed = await dispatcher.claimDueNotifications(session);

          final stored = await reload(record);

          expect(claimed.single.id, record.id);
          expect(stored.status, NotificationOutboxStatus.processing);
          expect(stored.lockedAt, now);
          expect(stored.attemptCount, 1);
          expect(sender.sent, isEmpty);
        },
      );

      test(
        'when more records are due than a batch holds then a claim is bounded',
        () async {
          for (var i = 0; i < NotificationOutboxDispatcher.batchSize + 5; i++) {
            await enqueue('device-$i');
          }

          final claimed = await dispatcher.claimDueNotifications(session);

          expect(claimed, hasLength(NotificationOutboxDispatcher.batchSize));

          // التشغيل الكامل يكمل ما تبقى على دفعات.
          await dispatcher.dispatchDueNotifications(session);

          expect(sender.sent, hasLength(5));
        },
      );

      test(
        'when two dispatchers claim at once then no record is claimed twice',
        () async {
          for (var i = 0; i < 30; i++) {
            await enqueue('device-$i');
          }

          final claims = await Future.wait([
            dispatcher.claimDueNotifications(sessionBuilder.build()),
            dispatcher.claimDueNotifications(sessionBuilder.build()),
          ]);

          final claimedIds = [
            for (final claim in claims)
              for (final notification in claim) notification.id,
          ];

          expect(claimedIds, hasLength(30));
          expect(claimedIds.toSet(), hasLength(30));
        },
      );

      test(
        'when two dispatchers run at once then every record is sent exactly once',
        () async {
          for (var i = 0; i < 50; i++) {
            await enqueue('device-$i');
          }

          await Future.wait([
            dispatcher.dispatchDueNotifications(sessionBuilder.build()),
            dispatcher.dispatchDueNotifications(sessionBuilder.build()),
          ]);

          final sentCount = await NotificationOutbox.db.count(
            session,
            where: (t) => t.status.equals(NotificationOutboxStatus.sent),
          );

          expect(sentCount, 50);
          expect(sender.sent, hasLength(50));
          expect(sender.installationIds.toSet(), hasLength(50));
        },
      );

      test(
        'when a slow send lost its claim then its outcome is ignored',
        () async {
          final record = await enqueue('device-1');

          // أثناء الإرسال ينتهي القفل ويستلم مشغّل آخر السجل.
          final slowDispatcher = NotificationOutboxDispatcher(
            clock: () => now,
            sender: (notification) async {
              now = now.add(
                NotificationOutboxDispatcher.lockLease +
                    const Duration(seconds: 1),
              );
              await dispatcher.claimDueNotifications(session);
              throw const SocketException('Connection reset');
            },
          );

          await slowDispatcher.dispatchDueNotifications(session);

          final stored = await reload(record);

          expect(stored.status, NotificationOutboxStatus.processing);
          expect(stored.attemptCount, 2);
          expect(stored.lockedAt, now);
          expect(stored.lastError, isNull);
        },
      );

      test(
        'when an unregistered response arrives after claim takeover '
        'then the installation is preserved',
        () async {
          await registerDevice('stale-device');
          final record = await enqueue('stale-device');

          final slowDispatcher = NotificationOutboxDispatcher(
            clock: () => now,
            sender: (notification) async {
              // نجعل القفل ينتهي أثناء الإرسال.
              now = now.add(
                NotificationOutboxDispatcher.lockLease +
                    const Duration(seconds: 1),
              );

              // عامل آخر يستحوذ على السجل.
              await dispatcher.claimDueNotifications(session);

              // العامل الأول يستقبل خطأ UNREGISTERED.
              throw _unregistered;
            },
          );

          await slowDispatcher.dispatchDueNotifications(session);

          final stored = await reload(record);

          // العامل الثاني ما زال يملك السجل.
          expect(stored.status, NotificationOutboxStatus.processing);
          expect(stored.attemptCount, 2);
          expect(stored.lockedAt, now);
          expect(stored.lastError, isNull);

          // لا يجوز حذف الجهاز بناءً على نتيجة العامل الأول.
          expect(await registeredDevices(), ['stale-device']);
        },
      );
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );
}
