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
import 'GamesTopUp.dart';
import 'firebase_options.dart';

Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {}
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
