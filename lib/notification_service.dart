import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  
  static Future<void> initialize() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

String? token = await FirebaseMessaging.instance.getToken();
print("FCM Token: $token");

    // طلب الإذن لتلقي الإشعارات
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }

    // تسجيل الجهاز للحصول على `fcm token`
    String? tokenn = await messaging.getToken();
    print("FCM Tokenn: $tokenn");

    // معالجة الإشعارات أثناء فتح التطبيق
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message received: ${message.notification?.title}');
    });

    // معالجة النقر على الإشعار
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification clicked: ${message.notification?.title}');
    });
  }
}
