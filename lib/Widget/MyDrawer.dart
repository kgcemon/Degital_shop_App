import 'package:flutter/material.dart';
import 'package:gamestopup/AllApiUrl/ApiEndpoint.dart';
import 'package:gamestopup/AllText.dart';
import 'package:gamestopup/Controller/Provider/HomeScreenProvider.dart';
import 'package:gamestopup/Controller/Provider/Profile_Provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../AllimagesLocation.dart';

class MyDrawer {
  static Widget myFullDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      child: ListView(children: [
        DrawerHeader(
            decoration: const BoxDecoration(color: Colors.green),
            padding: const EdgeInsets.all(0),
              child: UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color: Colors.green),
                  currentAccountPicture: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                        backgroundImage: AssetImage(ImagesLocation.profilePic)),
                  ),
                  accountName: Text(Provider.of<ProfileProvider>(context).name),
                  accountEmail:
                      Text(Provider.of<ProfileProvider>(context).phone)),
            ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: AllText.menuList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Consumer<HomeScreenProvider>(
                builder: (context, value, child) => ListTile(
                  onTap: () {
                    if (index == 0) {
                      Uri _url =
                          Uri.parse(value.noticeAndContract[index]['tutorial']);
                      Future<void> _launchUrl() async {
                        if (!await launchUrl(_url)) {
                          throw Exception('Could not launch $_url');
                        }
                      }

                      _launchUrl();
                    }

                    if (index == 1) {
                      Uri _url = Uri.parse(
                          "https://play.google.com/store/apps/details?id=com.codmshop.bd.gamestopup");
                      Future<void> _launchUrl() async {
                        if (!await launchUrl(_url)) {
                          throw Exception('Could not launch $_url');
                        }
                      }

                      _launchUrl();
                    }

                    if (index == 3) {
                      Uri _url = Uri.parse(
                          "${ApiEndPoint.mainUrl}/termsandconditions.html");
                      Future<void> _launchUrl() async {
                        if (!await launchUrl(_url)) {
                          throw Exception('Could not launch $_url');
                        }
                      }

                      _launchUrl();
                    }

                    if (index == 2) {
                      Share.share(
                          'Download Our Top Up App https://play.google.com/store/apps/details?id=com.codmshop.bd.gamestopup');
                    }
                  },
                  leading: AllText.menuList[index]['icon'],
                  title: Text(AllText.menuList[index]['name'],
                      style: const TextStyle(
                        fontFamily: 'BenSen',
                      )),
                ),
              ),
            );
          },
        )
      ]),
    );
  }
}
