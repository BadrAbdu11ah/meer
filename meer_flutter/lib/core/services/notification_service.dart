import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService({
    FirebaseMessaging? messaging,
    FlutterLocalNotificationsPlugin? localNotifications,
  }) : _messaging = messaging ?? FirebaseMessaging.instance,
       _localNotifications =
           localNotifications ?? FlutterLocalNotificationsPlugin();

  final FirebaseMessaging _messaging;
  final FlutterLocalNotificationsPlugin _localNotifications;

  static const String _channelId = 'meer_orders_channel';
  static const String _channelName = 'طلبات مِيْر';
  static const String _channelDescription =
      'إشعارات الطلبات وتحديث حالتها في مِيْر';

  final StreamController<String> _installationIdsController =
      StreamController<String>.broadcast();

  final StreamController<Map<String, dynamic>> _notificationOpenedController =
      StreamController<Map<String, dynamic>>.broadcast();

  StreamSubscription<String>? _registeredSubscription;
  StreamSubscription<RemoteMessage>? _foregroundSubscription;
  StreamSubscription<RemoteMessage>? _openedSubscription;

  String? _latestInstallationId;
  bool _initialized = false;
  bool _disposed = false;

  bool get _isSupportedPlatform =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  bool get _isAndroid =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  /// آخر Firebase Installation ID تم استلامه.
  String? get latestInstallationId => _latestInstallationId;

  /// المنصة الحالية بصيغة متوافقة مع الخادم.
  String? get supportedPlatform {
    if (!_isSupportedPlatform) return null;

    return _isAndroid ? 'android' : 'ios';
  }

  /// يستقبل تغيّر Firebase Installation ID.
  Stream<String> get onInstallationIdRegistered =>
      _installationIdsController.stream;

  /// يستقبل بيانات الإشعار عند الضغط عليه.
  Stream<Map<String, dynamic>> get onNotificationOpened =>
      _notificationOpenedController.stream;

  /// تهيئة الإشعارات المحلية ومستمعات Firebase.
  ///
  /// لا تطلب إذن الإشعارات من المستخدم هنا.
  Future<void> initialize() async {
    if (_disposed) {
      throw StateError(
        'NotificationService has been disposed.',
      );
    }

    if (_initialized) return;

    if (!_isSupportedPlatform) {
      _initialized = true;
      return;
    }

    // 1. تهيئة الإشعارات المحلية دون طلب الصلاحيات تلقائيًا.
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );

    await _localNotifications.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: _onLocalNotificationResponse,
    );

    // 2. إنشاء قناة إشعارات Android.
    if (_isAndroid) {
      const channel = AndroidNotificationChannel(
        _channelId,
        _channelName,
        description: _channelDescription,
        importance: Importance.max,
      );

      final androidPlugin = _localNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();

      await androidPlugin?.createNotificationChannel(channel);
    }

    // 3. متابعة تسجيل FID وتغيّره.
    _registeredSubscription = _messaging.onRegistered.listen(
      (installationId) {
        if (installationId.isEmpty) return;

        _latestInstallationId = installationId;

        if (!_installationIdsController.isClosed) {
          _installationIdsController.add(installationId);
        }
      },
      onError: (Object error) {
        if (!_installationIdsController.isClosed) {
          _installationIdsController.addError(error);
        }
      },
    );

    // 4. استقبال الرسائل أثناء فتح التطبيق.
    _foregroundSubscription = FirebaseMessaging.onMessage.listen(
      (message) {
        unawaited(_handleForegroundMessage(message));
      },
    );

    // 5. استقبال الضغط على إشعارات Firebase.
    _openedSubscription = FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        _notificationOpenedController.add(
          Map<String, dynamic>.from(message.data),
        );
      },
    );

    // 6. السماح بعرض إشعارات iOS أثناء فتح التطبيق.
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      await _messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    _initialized = true;
  }

  Future<void> dispose() async {
    if (_disposed) return;

    _disposed = true;

    await _registeredSubscription?.cancel();
    await _foregroundSubscription?.cancel();
    await _openedSubscription?.cancel();

    await _installationIdsController.close();
    await _notificationOpenedController.close();
  }

  /// طلب إذن الإشعارات وتسجيل الجهاز لدى Firebase.
  ///
  /// يرجع Firebase Installation ID، أو null إذا رفض المستخدم الإذن.
  Future<String?> requestPermissionAndRegister() async {
    if (!_initialized) {
      throw StateError(
        'NotificationService must be initialized first.',
      );
    }

    if (!_isSupportedPlatform) return null;

    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    final authorized =
        settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;

    if (!authorized) return null;

    // نبدأ الاستماع قبل register حتى لا نفقد حدث التسجيل.
    final installationIdCompleter = Completer<String>();

    final subscription = _installationIdsController.stream.listen(
      (installationId) {
        if (!installationIdCompleter.isCompleted) {
          installationIdCompleter.complete(installationId);
        }
      },
      onError: (Object error, StackTrace stackTrace) {
        if (!installationIdCompleter.isCompleted) {
          installationIdCompleter.completeError(error, stackTrace);
        }
      },
    );

    try {
      await _messaging.register();

      return await installationIdCompleter.future.timeout(
        const Duration(seconds: 30),
      );
    } finally {
      await subscription.cancel();
    }
  }

  /// إعادة تسجيل الجهاز لدى Firebase عند تشغيل التطبيق،
  /// بشرط أن يكون المستخدم قد منح إذن الإشعارات سابقًا.
  Future<void> refreshRegistrationIfPermitted() async {
    if (!_initialized) {
      throw StateError(
        'NotificationService must be initialized first.',
      );
    }

    if (!_isSupportedPlatform) return;

    final settings = await _messaging.getNotificationSettings();

    final authorized =
        settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;

    if (!authorized) return;

    await _messaging.register();
  }

  /// معالجة رسالة تصل والتطبيق مفتوح.
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    if (!_isAndroid) return;

    final remoteNotification = message.notification;

    final title =
        remoteNotification?.title ?? message.data['title']?.toString();

    final body = remoteNotification?.body ?? message.data['body']?.toString();

    if ((title == null || title.isEmpty) && (body == null || body.isEmpty)) {
      return;
    }

    await _showLocalNotification(
      id: _notificationId(message),
      title: title ?? 'مِيْر',
      body: body ?? '',
      payload: jsonEncode(message.data),
    );
  }

  /// عرض إشعار محلي على Android.
  Future<void> _showLocalNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      ),
    );

    await _localNotifications.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: notificationDetails,
      payload: payload,
    );
  }

  /// إنشاء معرّف رقمي للإشعار المحلي.
  int _notificationId(RemoteMessage message) {
    final messageId = message.messageId;

    if (messageId != null && messageId.isNotEmpty) {
      return messageId.hashCode & 0x7fffffff;
    }

    return DateTime.now().millisecondsSinceEpoch & 0x7fffffff;
  }

  /// معالجة الضغط على إشعار محلي.
  void _onLocalNotificationResponse(NotificationResponse response) {
    final data = _decodePayload(response.payload);

    if (data != null && !_notificationOpenedController.isClosed) {
      _notificationOpenedController.add(data);
    }
  }

  /// قراءة بيانات الإشعار الذي فتح التطبيق بعد إغلاقه.
  Future<Map<String, dynamic>?> getInitialNotificationData() async {
    if (!_initialized || !_isSupportedPlatform) return null;

    // إشعار Firebase فتح التطبيق.
    final remoteMessage = await _messaging.getInitialMessage();

    if (remoteMessage != null) {
      return Map<String, dynamic>.from(remoteMessage.data);
    }

    // إشعار محلي فتح التطبيق.
    final launchDetails = await _localNotifications
        .getNotificationAppLaunchDetails();

    if (launchDetails?.didNotificationLaunchApp != true) {
      return null;
    }

    return _decodePayload(
      launchDetails?.notificationResponse?.payload,
    );
  }

  /// تحويل Payload الإشعار إلى Map آمن.
  Map<String, dynamic>? _decodePayload(String? payload) {
    if (payload == null || payload.isEmpty) return null;

    try {
      final decoded = jsonDecode(payload);

      if (decoded is Map) {
        return Map<String, dynamic>.from(decoded);
      }
    } on FormatException {
      return null;
    }

    return null;
  }
}
