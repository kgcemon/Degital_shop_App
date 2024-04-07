import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gamestopup/Controller/SharedPreferencesInstance.dart';

class PushNotifications {

  static final firebaseMessaging = FirebaseMessaging.instance;

  static Future init() async{
    await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      carPlay: true,
      sound: true,
      criticalAlert: true
    );
    final token = await firebaseMessaging.getToken();
    SharedPreferencesInstance.sharedPreferencesRemove('token');
    await SharedPreferencesInstance.sharedPreferencesSet("token", token);
  }
}