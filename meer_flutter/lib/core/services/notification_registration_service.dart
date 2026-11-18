import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:meer_flutter/client.dart';
import 'package:meer_flutter/core/services/notification_service.dart';
import 'package:meer_flutter/repository/notification_repository.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationRegistrationService {
  NotificationRegistrationService({
    required this._notificationService,
    required this._notificationRepository,
    required this._preferences,
  });

  final NotificationService _notificationService;
  final NotificationRepository _notificationRepository;
  final SharedPreferences _preferences;

  static const _enabledKey = 'notifications_enabled';

  static const _registeredInstallationIdKey =
      'registered_notification_installation_id';

  StreamSubscription<String>? _installationSubscription;

  Future<void> _syncQueue = Future<void>.value();

  bool _initialized = false;
  bool _disposed = false;
  bool _signingOut = false;

  bool get _notificationsEnabled => _preferences.getBool(_enabledKey) ?? false;

  /// بدء مراقبة تغيّر FID وحالة المصادقة.
  Future<void> initialize() async {
    if (_initialized) return;

    // الاستماع إلى تغيّر Firebase Installation ID.
    _installationSubscription = _notificationService.onInstallationIdRegistered
        .listen(
          _handleInstallationRegistered,
          onError: (Object error) {
            debugPrint('Notification registration stream error: $error');
          },
        );

    // الاستماع إلى تسجيل الدخول والخروج في Serverpod.
    client.auth.authInfoListenable.addListener(
      _handleAuthChanged,
    );

    _initialized = true;

    // مزامنة الجهاز عند استعادة جلسة المستخدم.
    await _refreshForCurrentSession();
  }

  void _handleInstallationRegistered(String installationId) {
    if (_disposed || _signingOut) return;

    if (!_notificationsEnabled || !client.auth.isAuthenticated) {
      return;
    }

    _enqueueSync(installationId);
  }

  void _handleAuthChanged() {
    if (_disposed) return;

    if (client.auth.isAuthenticated) {
      _signingOut = false;
      unawaited(_refreshForCurrentSession());
    }
  }

  /// تحديث التسجيل بعد استعادة الجلسة أو تسجيل الدخول.
  Future<void> _refreshForCurrentSession() async {
    if (_disposed ||
        _signingOut ||
        !_notificationsEnabled ||
        !client.auth.isAuthenticated) {
      return;
    }

    // مزامنة آخر FID معروف، إن كان موجودًا.
    final currentId = _notificationService.latestInstallationId;

    if (currentId != null) {
      _enqueueSync(currentId);
    }

    try {
      // يطلب من Firebase إصدار حدث التسجيل بالمعرّف الحالي.
      await _notificationService.refreshRegistrationIfPermitted();
    } catch (error) {
      debugPrint('Failed to refresh Firebase registration: $error');
    }
  }

  /// إضافة عملية المزامنة إلى طابور حتى لا تتداخل الطلبات.
  void _enqueueSync(String installationId) {
    _syncQueue = _syncQueue.then(
      (_) => _syncInstallation(installationId),
    );
  }

  Future<void> _registerAndReplaceInstallation({
    required String installationId,
    required String platform,
  }) async {
    final previousInstallationId = _preferences.getString(
      _registeredInstallationIdKey,
    );

    // أولًا: تسجيل المعرّف الجديد بنجاح.
    await _notificationRepository.registerInstallation(
      installationId: installationId,
      platform: platform,
    );

    // ثانيًا: حذف التسجيل السابق إذا تغيّر FID.
    if (previousInstallationId != null &&
        previousInstallationId != installationId) {
      await _notificationRepository.unregisterInstallation(
        previousInstallationId,
      );
    }

    // ثالثًا: حفظ المعرّف الجديد بعد نجاح العمليتين.
    await _preferences.setString(
      _registeredInstallationIdKey,
      installationId,
    );
  }

  Future<void> _syncInstallation(String installationId) async {
    if (_disposed ||
        _signingOut ||
        !_notificationsEnabled ||
        !client.auth.isAuthenticated) {
      return;
    }

    final platform = _notificationService.supportedPlatform;

    if (platform == null) return;

    try {
      await _registerAndReplaceInstallation(
        installationId: installationId,
        platform: platform,
      );
    } catch (error, stackTrace) {
      debugPrint('Failed to sync notification installation: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  /// تفعيل الإشعارات وتسجيل الجهاز للمستخدم الحالي.
  ///
  /// يرجع true إذا اكتمل التسجيل على الخادم.
  Future<bool> enableNotifications() async {
    if (!_initialized) {
      throw StateError(
        'NotificationRegistrationService must be initialized first.',
      );
    }

    final platform = _notificationService.supportedPlatform;

    if (platform == null) return false;

    final installationId = await _notificationService
        .requestPermissionAndRegister();

    if (installationId == null) return false;

    await _registerAndReplaceInstallation(
      installationId: installationId,
      platform: platform,
    );

    await _preferences.setBool(_enabledKey, true);

    _signingOut = false;

    return true;
  }

  /// حذف ارتباط الجهاز قبل تسجيل خروج المستخدم.
  Future<void> unregisterCurrentInstallation() async {
    _signingOut = true;

    // انتظار عمليات المزامنة التي بدأت قبل تسجيل الخروج.
    await _syncQueue;

    final installationId =
        _preferences.getString(_registeredInstallationIdKey) ??
        _notificationService.latestInstallationId;

    if (installationId == null) return;

    await _notificationRepository.unregisterInstallation(
      installationId,
    );

    await _preferences.remove(
      _registeredInstallationIdKey,
    );
  }

  /// إعادة المزامنة إذا فشل تسجيل الخروج وبقي المستخدم مسجلًا.
  void resumeAfterSignOutFailure() {
    _signingOut = false;

    if (!_notificationsEnabled || !client.auth.isAuthenticated) {
      return;
    }

    final installationId = _notificationService.latestInstallationId;

    if (installationId != null) {
      _enqueueSync(installationId);
    }
  }

  Future<void> dispose() async {
    if (_disposed) return;

    _disposed = true;

    client.auth.authInfoListenable.removeListener(
      _handleAuthChanged,
    );

    await _installationSubscription?.cancel();
  }
}
