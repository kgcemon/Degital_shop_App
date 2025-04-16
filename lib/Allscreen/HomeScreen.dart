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
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LocalNotificationService.initialize(context);
      _loadAds();
    });

    await _setupFirebaseMessaging();
  }

  void _loadAds() {
    var adController = Provider.of<AdmobAdsController>(context, listen: false);
    adController.loadAdBannerAds();
    adController.showInterstitialAd();
  }

  Future<void> _setupFirebaseMessaging() async {
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationClick);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    if (message.notification != null) {
      await _storeNotification(message);
      Provider.of<HomeScreenProvider>(context, listen: false).loadAllApiData();
      LocalNotificationService.display(message);
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await _storeNotification(message);
    LocalNotificationService.display(message);
  }

  static Future<void> _storeNotification(RemoteMessage message) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> notification = {
      "title": message.notification?.title ?? "No Title",
      "body": message.notification?.body ?? "No Body"
    };
    await prefs.setString("order", jsonEncode(notification));
  }

  Future<void> _handleNotificationClick(RemoteMessage message) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> notification = {
      "title": message.notification?.title ?? "No Title",
      "body": message.notification?.body ?? "No Body"
    };
    await prefs.setString("order", jsonEncode(notification));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message.notification?.title ?? "Notification"),
          content: Text(message.notification?.body ?? "You have a new message."),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          floatingActionButton: FlotingHelpBar().flotingHelpBar(context),
          drawer: MyDrawer.myFullDrawer(context),
          bottomNavigationBar: Consumer<HomeScreenProvider>(
            builder: (context, value, child) =>
                MyBottomNaviBar.bottomNaviBar(value.index, context),
          ),
          appBar: MyAppBar.myAppBar(
              context: context,
              titleWidget: Image.asset(
                ImagesLocation.myLogo,
                width: constraints.maxWidth * 0.25, // Responsive width
              )
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth * 0.02, // Responsive padding
              ),
              child: Column(
                children: [
                  Consumer<HomeScreenProvider>(
                    builder: (context, value, child) => value.pageChange(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}