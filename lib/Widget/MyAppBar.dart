import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:gamestopup/Allscreen/notification_receiver_screen.dart';
import 'package:gamestopup/Controller/Provider/HomeScreenProvider.dart';
import 'package:provider/provider.dart';

class MyAppBar {
  static myAppBar(
      {required BuildContext context, required Widget titleWidget}) {
    return AppBar(
      centerTitle: true,
      title: titleWidget,
      actions: [
        Consumer<HomeScreenProvider>(
          builder: (context, value, child) => GestureDetector(
            onTap: () =>  Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationReceiverScreen(),
              ),
            ),
            child: badges.Badge(
              badgeContent: Text(value.notificationMap?.length.toString() ?? "0"),
              child: const Icon(Icons.notifications),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        )
      ],
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      surfaceTintColor: Colors.white,
      scrolledUnderElevation: 0,
      backgroundColor: const Color(0xff0D6EFC),
      shadowColor: Colors.green,
    );
  }
}
