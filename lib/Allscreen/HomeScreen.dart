import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gamestopup/AllimagesLocation.dart';
import 'package:gamestopup/Controller/Provider/HomeScreenProvider.dart';
import 'package:gamestopup/Controller/Provider/admob_controller_provider.dart';
import 'package:gamestopup/Widget/FlotingHelpBar.dart';
import 'package:gamestopup/Widget/MyDrawer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widget/MyAppBar.dart';
import '../Widget/bottonNviBar.dart';
import '../local_notification_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    // Initialize local notifications
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LocalNotificationService.initialize(context);
    });

    // Load ads only if necessary (avoiding unnecessary resource usage)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var data = Provider.of<AdmobAdsController>(context, listen: false);
      data.loadNativeAd();
      data.loadBannerAd();
      data.loadInterstitialAd();
    });

    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        LocalNotificationService.display(message);
      }
    });

    // Listen for background and terminated messages
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationClick(message);
    });

    // Set up background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> notification = {
      "title": message.notification?.title ?? "No Title",
      "body": message.notification?.body ?? "No Body"
    };

    // Store the notification as a string in SharedPreferences
    await prefs.setString("order", jsonEncode(notification));

    LocalNotificationService.display(message);
  }

  void _handleNotificationClick(RemoteMessage message) {
    // Show a dialog when a notification is clicked
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message.notification?.title ?? "Notification"),
          content: Text(message.notification?.body ?? "You have a new message."),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FlotingHelpBar().flotingHelpBar(context),
      drawer: MyDrawer.myFullDrawer(context),
      bottomNavigationBar: Consumer<HomeScreenProvider>(
        builder: (context, value, child) =>
            MyBottomNaviBar.bottomNaviBar(value.index, context),
      ),
      appBar: MyAppBar.myAppBar(context: context, titleWidget: Image.asset(ImagesLocation.myLogo, width: 100)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Consumer<HomeScreenProvider>(
              builder: (context, value, child) => value.pageChange(context),
            ),
          ],
        ),
      ),
    );
  }
}