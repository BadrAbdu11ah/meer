// import 'package:meer/core/services/notification_service.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:shared_preferences/shared_preferences.dart';

// دالة تعمل في الخلفية عند وصول إشعار والتطبيق مغلق أو بالخلفية
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // تهيئة الفايربيس للـ Background Process
//   await Firebase.initializeApp();
//   print("=================== Background Notification ===================");
//   print(message.notification?.title);
//   print(message.notification?.body);
//   print("=============================================================");
// }

class AppService {
  static final AppService _instance = AppService._internal();
  factory AppService() => _instance;
  AppService._internal();

  late final SharedPreferences sharedPreferences;

  Future<void> init() async {
    // 1. تهيئة الفايربيس
    // await Firebase.initializeApp();

    // 2. تهيئة خدمات الإشعارات (FCM + Local Notifications)
    // await NotificationService.initialize();

    // 3. تسجيل معالج الإشعارات في الخلفية
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 4. تهيئة SharedPreferences
    sharedPreferences = await SharedPreferences.getInstance();
  }
}

Future<void> initialService() async {
  await AppService().init();
}
