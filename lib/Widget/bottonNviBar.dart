import 'package:flutter/material.dart';
import 'package:gamestopup/AllText.dart';
import 'package:gamestopup/Controller/Provider/HomeScreenProvider.dart';
import 'package:provider/provider.dart';

class MyBottomNaviBar {
  static Widget bottomNaviBar(int index, BuildContext context){
    return
      BottomNavigationBar(
        selectedIconTheme: const IconThemeData(color: Colors.white),
        unselectedIconTheme: const IconThemeData(color: Colors.black),
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.green,
        currentIndex: index,
        onTap: (value) {
          Provider.of<HomeScreenProvider>(context, listen: false)
              .bottomNavigationBar(value);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AllText.bottomNavigationBarItemTextHome,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_open),
            label: AllText.bottomNavigationBarItemTextProfile,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: AllText.bottomNavigationBarItemTextOrder,
          ),
        ],
      );
  }

}

