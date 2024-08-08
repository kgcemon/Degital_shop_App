import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LocalNotificationService.initialize(context);
    });
    var data = Provider.of<AdmobAdsController>(context,listen: false);
    data.loadAd();
    data.loadAdBannerAds();
    data.showInterstitialAd();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        LocalNotificationService.display(message);
      }
    });
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
      appBar: MyAppBar.myAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Consumer<HomeScreenProvider>(
              builder: (context, value, child) => value.pageChange(),
            ),
          ],
        ),
      ),
    );
  }
}
