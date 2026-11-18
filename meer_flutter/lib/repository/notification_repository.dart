import 'package:meer_flutter/client.dart';

class NotificationRepository {
  /// تسجيل الجهاز وربطه بالمستخدم المصادق عليه.
  Future<void> registerInstallation({
    required String installationId,
    required String platform,
  }) async {
    await client.notification.registerInstallation(
      installationId,
      platform,
    );
  }

  /// حذف ربط الجهاز بالمستخدم الحالي.
  Future<void> unregisterInstallation(
    String installationId,
  ) async {
    await client.notification.unregisterInstallation(
      installationId,
    );
  }
}
