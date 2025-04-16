         import 'dart:convert';
import  'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gamestopup/Controller/Provider/CheckoutProvider.dart';
import 'package:gamestopup/Controller/Provider/HomeScreenProvider.dart';
import 'package:gamestopup/Controller/Provider/ItemListWidgetProvider.dart';
import 'package:gamestopup/Controller/Provider/Profile_Provider.dart';
import 'package:gamestopup/Controller/Provider/admob_controller_provider.dart';
import 'package:gamestopup/PushNotifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'GamesTopUp.dart';
import 'firebase_options.dart';
import 'local_notification_service.dart';

Future _firebaseBackgroundMessage(RemoteMessage message) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (message.notification != null) {
   await prefs.remove("order");
    Map<String, String> notification = {
      "title": message.notification?.title ?? "No Title",
      "body": message.notification?.body ?? "No Body"
    };

    // Store the notification as a string in SharedPreferences
    await prefs.setString("order", jsonEncode(notification));

    LocalNotificationService.display(message);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PushNotifications.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ItemListWidgetProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CheckOutProvider(),
        ),
        ChangeNotifierProvider(create: (context) => ProfileProvider(),),
        ChangeNotifierProvider(create: (context) => AdmobAdsController(),),
      ],
      child: const GamesTopUp(),
    ),
  );
}
