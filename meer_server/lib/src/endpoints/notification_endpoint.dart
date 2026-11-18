import 'package:meer_server/src/generated/protocol.dart';
import 'package:meer_server/src/services/fcm_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

class NotificationEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  String _validateInstallationId(String installationId) {
    final normalized = installationId.trim();

    if (normalized.isEmpty ||
        normalized.length > 256 ||
        RegExp(r'\s').hasMatch(normalized)) {
      throw FormatException('معرّف تثبيت الجهاز غير صالح.');
    }

    return normalized;
  }

  String _validatePlatform(String platform) {
    final normalized = platform.trim().toLowerCase();

    if (!const {'android', 'ios'}.contains(normalized)) {
      throw FormatException('منصة الجهاز غير مدعومة.');
    }

    return normalized;
  }

  /// تسجيل الجهاز وربطه بالمستخدم الحالي.
  Future<void> registerInstallation(
    Session session,
    String installationId,
    String platform,
  ) async {
    final authUserId = session.authenticated?.authUserId;

    if (authUserId == null) {
      throw Exception('يجب تسجيل الدخول أولًا.');
    }

    final normalizedInstallationId = _validateInstallationId(installationId);

    final normalizedPlatform = _validatePlatform(platform);

    await UserDeviceInstallation.db.upsertRow(
      session,
      UserDeviceInstallation(
        authUserId: authUserId,
        installationId: normalizedInstallationId,
        platform: normalizedPlatform,
        lastSeenAt: DateTime.now(),
      ),
      conflictColumns: (t) => [t.installationId],
      updateColumns: (t) => [
        t.authUserId,
        t.platform,
        t.lastSeenAt,
      ],
    );
  }

  /// حذف تسجيل الجهاز من حساب المستخدم الحالي.
  Future<void> unregisterInstallation(
    Session session,
    String installationId,
  ) async {
    final authUserId = session.authenticated?.authUserId;

    if (authUserId == null) {
      throw Exception('يجب تسجيل الدخول أولًا.');
    }

    final normalizedInstallationId = _validateInstallationId(installationId);

    await UserDeviceInstallation.db.deleteWhere(
      session,
      where: (t) =>
          t.authUserId.equals(authUserId) &
          t.installationId.equals(normalizedInstallationId),
    );
  }

  /// إرسال إشعار تجريبي إلى أجهزة المستخدم الحالي فقط.
  Future<int> sendTestNotificationToMyDevices(
    Session session,
  ) async {
    final authUserId = session.authenticated?.authUserId;

    if (authUserId == null) {
      throw Exception('يجب تسجيل الدخول أولًا.');
    }

    // جلب الأجهزة المرتبطة بالمستخدم الحالي.
    final installations = await UserDeviceInstallation.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );

    if (installations.isEmpty) {
      return 0;
    }

    final fcmService = FcmService();

    try {
      await fcmService.initialize();

      var sentCount = 0;

      for (final installation in installations) {
        await fcmService.sendToInstallation(
          installationId: installation.installationId,
          title: 'مِيْر',
          body: 'هذا إشعار تجريبي. نظام الإشعارات يعمل بنجاح!',
          data: {
            'type': 'test',
            'event': 'test_notification',
          },
        );

        sentCount++;
      }

      return sentCount;
    } finally {
      fcmService.dispose();
    }
  }
}
