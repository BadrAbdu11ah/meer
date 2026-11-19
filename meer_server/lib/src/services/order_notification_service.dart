import 'dart:developer' as developer;

import 'package:meer_server/src/generated/protocol.dart';
import 'package:meer_server/src/services/fcm_service.dart';
import 'package:serverpod/serverpod.dart';

class OrderNotificationService {
  static final FcmService _fcmService = FcmService();

  /// إشعار البائع عند وصول طلب جديد.
  Future<void> notifyNewOrderToSeller(
    Session session,
    OrderInfo order,
  ) async {
    await _notifyProfile(
      session: session,
      recipientProfileId: order.sellerId,
      actorProfileId: order.customerId,
      order: order,
      title: 'طلب جديد #${order.id}',
      bodyBuilder: (actorName) => 'وصلك طلب جديد من العميل $actorName.',
      event: 'new_order',
    );
  }

  /// إشعار العميل عند قبول الطلب.
  Future<void> notifyOrderAcceptedToCustomer(
    Session session,
    OrderInfo order,
  ) async {
    await _notifyProfile(
      session: session,
      recipientProfileId: order.customerId,
      actorProfileId: order.sellerId,
      order: order,
      title: 'تم قبول طلبك #${order.id}',
      bodyBuilder: (actorName) => 'قبلت الأسرة $actorName طلبك وبدأت تجهيزه.',
      event: 'order_accepted',
    );
  }

  /// إشعار العميل عند رفض الطلب.
  Future<void> notifyOrderRejectedToCustomer(
    Session session,
    OrderInfo order,
  ) async {
    await _notifyProfile(
      session: session,
      recipientProfileId: order.customerId,
      actorProfileId: order.sellerId,
      order: order,
      title: 'تعذر تنفيذ طلبك #${order.id}',
      bodyBuilder: (actorName) => 'لم تتمكن الأسرة $actorName من تنفيذ طلبك.',
      event: 'order_rejected',
    );
  }

  /// إشعار العميل عند جاهزية الطلب.
  Future<void> notifyOrderReadyToCustomer(
    Session session,
    OrderInfo order,
  ) async {
    await _notifyProfile(
      session: session,
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
  Future<void> notifyOrderCancelledToSeller(
    Session session,
    OrderInfo order,
  ) async {
    await _notifyProfile(
      session: session,
      recipientProfileId: order.sellerId,
      actorProfileId: order.customerId,
      order: order,
      title: 'إلغاء الطلب #${order.id}',
      bodyBuilder: (actorName) => 'ألغى العميل $actorName الطلب.',
      event: 'order_cancelled',
    );
  }

  /// إرسال إشعار إلى جميع أجهزة المستلم.
  Future<void> _notifyProfile({
    required Session session,
    required int recipientProfileId,
    required int actorProfileId,
    required OrderInfo order,
    required String title,
    required String Function(String actorName) bodyBuilder,
    required String event,
  }) async {
    try {
      final orderId = order.id;

      if (orderId == null) {
        developer.log(
          'Cannot notify: order ID is missing.',
          name: 'meer.notifications',
        );
        return;
      }

      // 1. جلب ملف المستلم.
      final recipient = await MeerUserProfile.db.findById(
        session,
        recipientProfileId,
      );

      final authUserId = recipient?.authUserId;

      if (recipient == null || authUserId == null) {
        developer.log(
          'Recipient profile or authentication link not found.',
          name: 'meer.notifications',
        );
        return;
      }

      // 2. جلب اسم الطرف الذي قام بالعملية.
      final actor = await MeerUserProfile.db.findById(
        session,
        actorProfileId,
      );

      final actorName = actor?.fullName.trim();

      final displayName = actorName == null || actorName.isEmpty
          ? 'أحد مستخدمي مِيْر'
          : actorName;

      // 3. جلب جميع أجهزة المستلم.
      final installations = await UserDeviceInstallation.db.find(
        session,
        where: (t) => t.authUserId.equals(authUserId),
      );

      if (installations.isEmpty) {
        developer.log(
          'No registered devices for profile $recipientProfileId.',
          name: 'meer.notifications',
        );
        return;
      }

      // 4. تهيئة FCM.
      await _fcmService.initialize();

      // 5. إرسال الإشعار لجميع الأجهزة.
      for (final installation in installations) {
        try {
          await _fcmService.sendToInstallation(
            installationId: installation.installationId,
            title: title,
            body: bodyBuilder(displayName),
            data: {
              'type': 'order',
              'event': event,
              'orderId': orderId.toString(),
              'actorName': displayName,
            },
          );
        } catch (error, stackTrace) {
          developer.log(
            'Failed to send $event notification '
            'for order $orderId to installation ${installation.id}.',
            name: 'meer.notifications',
            error: error,
            stackTrace: stackTrace,
          );
        }
      }
    } catch (error, stackTrace) {
      // فشل الإشعار لا يؤثر على عملية الطلب.
      developer.log(
        'Order notification service failed for order ${order.id}.',
        name: 'meer.notifications',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
