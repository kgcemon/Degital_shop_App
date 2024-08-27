import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gamestopup/AllimagesLocation.dart';
import 'package:gamestopup/Controller/Provider/HomeScreenProvider.dart';
import 'package:gamestopup/Controller/Provider/admob_controller_provider.dart';
import 'package:gamestopup/Widget/FlotingHelpBar.dart';
import 'package:gamestopup/Widget/MyDrawer.dart';
import 'package:provider/provider.dart';
import '../Widget/MyAppBar.dart';
import '../Widget/bottonNviBar.dart';
import '../local_notification_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
      data.loadAd();
      data.loadAdBannerAds();
      data.showInterstitialAd();
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

    // Handle background messages (when the app is not in the foreground)
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // Handle background notifications here (e.g., navigate to a specific screen, etc.)
    print("Handling a background message: ${message.messageId}");
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
      appBar: MyAppBar.myAppBar(context: context, titleWidget: Image.asset(ImagesLocation.myLogo,width: 100,)),
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
