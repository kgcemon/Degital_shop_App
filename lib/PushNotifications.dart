import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gamestopup/Controller/SharedPreferencesInstance.dart';
import 'local_notification_service.dart';

class PushNotifications {
  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    try {
      // Request permissions for iOS devices
      await firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        carPlay: true,
        sound: true,
        criticalAlert: true,
      );

      // Retrieve the FCM token
      final token = await firebaseMessaging.getToken();

      if (token != null) {
        // Store the token in shared preferences
        SharedPreferencesInstance.sharedPreferencesRemove('token');
        await SharedPreferencesInstance.sharedPreferencesSet("token", token);
      }

      // Listen to foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (message.notification != null) {
          // Handle foreground notification here, such as showing a pop-up
          LocalNotificationService.display(message);
        }
      });
    } catch (e) {
      print('Error initializing Firebase Messaging: $e');
      // You can add more sophisticated error handling here
    }
  }
}
