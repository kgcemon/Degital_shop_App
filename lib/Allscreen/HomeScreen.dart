import 'package:flutter/material.dart';
import 'package:gamestopup/Controller/Provider/HomeScreenProvider.dart';
import 'package:gamestopup/Widget/FlotingHelpBar.dart';
import 'package:gamestopup/Widget/MyDrawer.dart';
import 'package:provider/provider.dart';
import '../Widget/MyAppBar.dart';
import '../Widget/bottonNviBar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
