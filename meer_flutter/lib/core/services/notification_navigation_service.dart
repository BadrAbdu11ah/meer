import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:meer_flutter/client.dart';
import 'package:meer_flutter/core/constant/app_route.dart';
import 'package:meer_flutter/core/routes/app_navigator.dart';
import 'package:meer_flutter/core/routes/main_screen_route_arguments.dart';
import 'package:meer_flutter/core/routes/order_details_route_arguments.dart';
import 'package:meer_flutter/core/services/notification_service.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class NotificationNavigationService {
  NotificationNavigationService({
    required this._notificationService,
  });

  final NotificationService _notificationService;

  StreamSubscription<Map<String, dynamic>>? _subscription;

  Map<String, dynamic>? _pendingNotification;

  bool _initialized = false;
  bool _disposed = false;

  /// بدء الاستماع إلى ضغط الإشعارات وفحص إشعار فتح التطبيق.
  Future<void> initialize() async {
    if (_initialized) return;

    if (_disposed) {
      throw StateError(
        'NotificationNavigationService has been disposed.',
      );
    }

    _subscription = _notificationService.onNotificationOpened.listen(
      _handleNotification,
      onError: (Object error, StackTrace stackTrace) {
        developer.log(
          'Notification navigation stream failed.',
          name: 'meer.notifications',
          error: error,
          stackTrace: stackTrace,
        );
      },
    );

    client.auth.authInfoListenable.addListener(_handleAuthChanged);

    _initialized = true;

    // استعادة الإشعار الذي فتح التطبيق بعد إغلاقه.
    try {
      final initialData = await _notificationService
          .getInitialNotificationData();

      if (initialData != null) {
        _handleNotification(initialData);
      }
    } catch (error, stackTrace) {
      developer.log(
        'Failed to read initial notification.',
        name: 'meer.notifications',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// معالجة الإشعار عند الضغط عليه.
  void _handleNotification(Map<String, dynamic> data) {
    if (_disposed) return;

    if (data['type']?.toString() != 'order') return;

    final event = data['event']?.toString();

    final orderId = int.tryParse(
      data['orderId']?.toString() ?? '',
    );

    if (orderId == null || orderId <= 0) {
      developer.log(
        'Notification contains an invalid order ID.',
        name: 'meer.notifications',
      );
      return;
    }

    final isSellerNotification =
        event == 'new_order' || event == 'order_cancelled';

    final isCustomerNotification =
        event == 'order_accepted' ||
        event == 'order_rejected' ||
        event == 'order_ready';

    if (!isSellerNotification && !isCustomerNotification) {
      return;
    }

    // الاحتفاظ بالإشعار إذا لم يكن المستخدم مسجل الدخول.
    if (!client.auth.isAuthenticated) {
      _pendingNotification = Map<String, dynamic>.from(data);

      _navigateTo(
        AppRoute.loginScreen,
        clearStack: true,
      );
      return;
    }

    _pendingNotification = null;

    if (isSellerNotification) {
      _openSellerOrder(orderId);
      return;
    }

    // إشعارات العميل تفتح MainScreen على تبويب طلباتي.
    _openCustomerOrder(orderId);
  }

  /// فتح تفاصيل طلب العميل مع إبقاء قائمة طلباتي خلفها.
  void _openCustomerOrder(int orderId) {
    _navigateTo(
      AppRoute.mainScreen,
      arguments: const MainScreenRouteArguments(
        initialPage: 2,
      ),
      clearStack: true,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_disposed) return;

      _navigateTo(
        AppRoute.orderDetailsScreen,
        arguments: OrderDetailsRouteArguments(
          orderId: orderId,
          isSellerView: false,
        ),
      );
    });
  }

  /// فتح تفاصيل طلب البائع مع إبقاء قائمة الطلبات الواردة خلفها.
  void _openSellerOrder(int orderId) {
    _navigateTo(
      AppRoute.mainScreen,
      arguments: const MainScreenRouteArguments(
        initialPage: 3,
      ),
      clearStack: true,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_disposed) return;

      // فتح قائمة الطلبات الواردة أولاً.
      _navigateTo(AppRoute.sellerOrdersScreen);

      // بعد إنشاء شاشة القائمة، افتح تفاصيل الطلب فوقها.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_disposed) return;

        _navigateTo(
          AppRoute.orderDetailsScreen,
          arguments: OrderDetailsRouteArguments(
            orderId: orderId,
            isSellerView: true,
          ),
        );
      });
    });
  }

  /// معالجة تسجيل الدخول عند وجود إشعار مؤجل.
  void _handleAuthChanged() {
    if (_disposed || !client.auth.isAuthenticated) return;

    final pending = _pendingNotification;

    if (pending == null) return;

    _pendingNotification = null;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_disposed || !client.auth.isAuthenticated) return;

      _handleNotification(pending);
    });
  }

  /// التنقل مع الحفاظ على سجل الصفحات أو مسحه عند الحاجة.
  void _navigateTo(
    String routeName, {
    Object? arguments,
    bool clearStack = false,
  }) {
    if (_disposed) return;

    final navigator = appNavigatorKey.currentState;

    if (navigator == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigateTo(
          routeName,
          arguments: arguments,
          clearStack: clearStack,
        );
      });
      return;
    }

    if (clearStack) {
      navigator.pushNamedAndRemoveUntil(
        routeName,
        (route) => false,
        arguments: arguments,
      );
    } else {
      navigator.pushNamed(
        routeName,
        arguments: arguments,
      );
    }
  }

  /// إلغاء الاشتراكات ومستمع المصادقة عند التخلص من الخدمة.
  Future<void> dispose() async {
    if (_disposed) return;

    _disposed = true;

    client.auth.authInfoListenable.removeListener(
      _handleAuthChanged,
    );

    await _subscription?.cancel();
    _subscription = null;
  }
}
