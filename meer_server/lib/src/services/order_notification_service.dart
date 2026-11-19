import 'package:meer_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Creates [NotificationOutbox] records for order events.
///
/// Nothing is sent from here. Every method runs inside the caller's order
/// [Transaction], so the order change and its outbox records are committed or
/// rolled back together. Delivery happens later in
/// `NotificationOutboxDispatcher`.
class OrderNotificationService {
  /// إشعار البائع عند وصول طلب جديد.
  Future<void> enqueueNewOrderForSeller(
    Session session,
    OrderInfo order, {
    required Transaction transaction,
  }) async {
    await _enqueueForProfile(
      session: session,
      transaction: transaction,
      recipientProfileId: order.sellerId,
      actorProfileId: order.customerId,
      order: order,
      title: 'طلب جديد #${order.id}',
      bodyBuilder: (actorName) => 'وصلك طلب جديد من العميل $actorName.',
      event: 'new_order',
    );
  }

  /// إشعار العميل عند قبول الطلب.
  Future<void> enqueueOrderAcceptedForCustomer(
    Session session,
    OrderInfo order, {
    required Transaction transaction,
  }) async {
    await _enqueueForProfile(
      session: session,
      transaction: transaction,
      recipientProfileId: order.customerId,
      actorProfileId: order.sellerId,
      order: order,
      title: 'تم قبول طلبك #${order.id}',
      bodyBuilder: (actorName) => 'قبلت الأسرة $actorName طلبك وبدأت تجهيزه.',
      event: 'order_accepted',
    );
  }

  /// إشعار العميل عند رفض الطلب.
  Future<void> enqueueOrderRejectedForCustomer(
    Session session,
    OrderInfo order, {
    required Transaction transaction,
  }) async {
    await _enqueueForProfile(
      session: session,
      transaction: transaction,
      recipientProfileId: order.customerId,
      actorProfileId: order.sellerId,
      order: order,
      title: 'تعذر تنفيذ طلبك #${order.id}',
      bodyBuilder: (actorName) => 'لم تتمكن الأسرة $actorName من تنفيذ طلبك.',
      event: 'order_rejected',
    );
  }

  /// إشعار العميل عند جاهزية الطلب.
  Future<void> enqueueOrderReadyForCustomer(
    Session session,
    OrderInfo order, {
    required Transaction transaction,
  }) async {
    await _enqueueForProfile(
      session: session,
      transaction: transaction,
      recipientProfileId: order.customerId,
      actorProfileId: order.sellerId,
      order: order,
      title: 'طلبك جاهز #${order.id}',
      bodyBuilder: (actorName) {
        if (order.fulfillmentMethod == 'pickup') {
          return 'طلبك جاهز للاستلام من الأسرة $actorName.';
        }

        return 'الأسرة $actorName جهزت طلبك للتوصيل.';
      },
      event: 'order_ready',
    );
  }

  /// إشعار البائع عند إلغاء العميل للطلب.
  Future<void> enqueueOrderCancelledForSeller(
    Session session,
    OrderInfo order, {
    required Transaction transaction,
  }) async {
    await _enqueueForProfile(
      session: session,
      transaction: transaction,
      recipientProfileId: order.sellerId,
      actorProfileId: order.customerId,
      order: order,
      title: 'إلغاء الطلب #${order.id}',
      bodyBuilder: (actorName) => 'ألغى العميل $actorName الطلب.',
      event: 'order_cancelled',
    );
  }

  /// The key that makes an event unique per order and device installation.
  static String dedupeKey({
    required int orderId,
    required String event,
    required String installationId,
  }) {
    return '$orderId:$event:$installationId';
  }

  /// إضافة سجل Outbox لكل جهاز مسجل للمستلم.
  ///
  /// Database errors are not caught: they abort [transaction], and the order
  /// change is rolled back with it.
  Future<void> _enqueueForProfile({
    required Session session,
    required Transaction transaction,
    required int recipientProfileId,
    required int actorProfileId,
    required OrderInfo order,
    required String title,
    required String Function(String actorName) bodyBuilder,
    required String event,
  }) async {
    final orderId = order.id;

    if (orderId == null) {
      session.log(
        'Cannot enqueue $event notification: order ID is missing.',
        level: LogLevel.warning,
      );
      return;
    }

    // 1. جلب ملف المستلم.
    final recipient = await MeerUserProfile.db.findById(
      session,
      recipientProfileId,
      transaction: transaction,
    );

    final authUserId = recipient?.authUserId;

    if (recipient == null || authUserId == null) {
      session.log(
        'Cannot enqueue $event notification for order $orderId: '
        'recipient profile or authentication link not found.',
        level: LogLevel.warning,
      );
      return;
    }

    // 2. جلب اسم الطرف الذي قام بالعملية.
    final actor = await MeerUserProfile.db.findById(
      session,
      actorProfileId,
      transaction: transaction,
    );

    final actorName = actor?.fullName.trim();

    final displayName = actorName == null || actorName.isEmpty
        ? 'أحد مستخدمي مِيْر'
        : actorName;

    // 3. جلب جميع أجهزة المستلم.
    final installations = await UserDeviceInstallation.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
      transaction: transaction,
    );

    if (installations.isEmpty) {
      session.log(
        'No registered devices for profile $recipientProfileId; '
        'no $event notification enqueued for order $orderId.',
      );
      return;
    }

    // 4. سجل واحد لكل جهاز حتى تعاد المحاولة للجهاز الفاشل فقط.
    final body = bodyBuilder(displayName);
    final now = DateTime.now().toUtc();

    final records = [
      for (final installation in installations)
        NotificationOutbox(
          recipientProfileId: recipientProfileId,
          installationId: installation.installationId,
          orderId: orderId,
          event: event,
          title: title,
          body: body,
          data: {
            'type': 'order',
            'event': event,
            'orderId': orderId.toString(),
            'actorName': displayName,
          },
          nextAttemptAt: now,
          createdAt: now,
          dedupeKey: dedupeKey(
            orderId: orderId,
            event: event,
            installationId: installation.installationId,
          ),
        ),
    ];

    // A repeated enqueue of the same event hits the unique dedupe key and is
    // skipped (ON CONFLICT DO NOTHING) instead of failing the transaction.
    await NotificationOutbox.db.insert(
      session,
      records,
      transaction: transaction,
      ignoreConflicts: true,
    );
  }
}
