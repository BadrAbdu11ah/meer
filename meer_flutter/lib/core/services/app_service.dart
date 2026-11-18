import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:meer_flutter/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// يعمل في Isolate منفصل عند وصول رسالة في الخلفية.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // سنضيف معالجة بيانات الإشعار هنا لاحقًا.
}

class AppService {
  static final AppService _instance = AppService._internal();

  factory AppService() => _instance;

  AppService._internal();

  late final SharedPreferences sharedPreferences;

  Future<void> init() async {
    // 1. تهيئة Firebase.
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // 2. تسجيل معالج رسائل الخلفية للمنصات المدعومة.
    // Web له Service Worker خاص، وWindows ليس ضمن منصات
    // Firebase Messaging التي نستهدفها.
    if (!kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.macOS)) {
      FirebaseMessaging.onBackgroundMessage(
        firebaseMessagingBackgroundHandler,
      );
    }

    // 3. تهيئة SharedPreferences.
    sharedPreferences = await SharedPreferences.getInstance();
  }
}

Future<void> initialService() async {
  await AppService().init();
}
