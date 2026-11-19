import 'package:meer_server/src/services/notification_outbox_dispatcher.dart';
import 'package:serverpod/serverpod.dart';

/// Delivers due order notifications from the outbox.
///
/// Scheduled as a recurring call in `lib/server.dart`.
class NotificationOutboxFutureCall extends FutureCall {
  /// Identifies the recurring call, so it can be cancelled and rescheduled.
  static const recurringIdentifier = 'notification-outbox-dispatch';

  static const interval = Duration(seconds: 15);

  Future<void> dispatch(Session session) async {
    final claimedCount = await NotificationOutboxDispatcher()
        .dispatchDueNotifications(session);

    if (claimedCount > 0) {
      session.log('Notification outbox: processed $claimedCount record(s).');
    }
  }
}
