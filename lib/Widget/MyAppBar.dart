import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:gamestopup/AllimagesLocation.dart';
import 'package:gamestopup/Controller/Provider/HomeScreenProvider.dart';
import 'package:gamestopup/Widget/StockOutPopUp.dart';
import 'package:provider/provider.dart';

class MyAppBar {
  static myAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Image.asset(ImagesLocation.myLogo, height: 75),
      actions: [
        Consumer<HomeScreenProvider>(
          builder: (context, value, child) => badges.Badge(
            badgeContent: const Text('1'),
            child: InkWell(
                onTap: () => StockOutPopUp.showStockOutPopup(
                    context,
                    "Notice",
                    Center(
                        child: Text(
                      value.noticeAndContract[0]['notice'],
                      style: const TextStyle(fontFamily: 'BenSen'),
                    ))),
                child: const Icon(Icons.notifications)),
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
      backgroundColor: Colors.green,
      shadowColor: Colors.green,
    );
  }
}
