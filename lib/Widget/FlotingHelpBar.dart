import 'package:flutter/material.dart';
import 'package:gamestopup/Controller/Provider/HomeScreenProvider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../AllText.dart';

class FlotingHelpBar {

 Widget flotingHelpBar(BuildContext context) {
    return Consumer<HomeScreenProvider>(builder: (context, value, child) => FloatingActionButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(50)),
      backgroundColor: Colors.white,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.headset_mic_rounded, color: Colors.green, size: 25),
          FittedBox(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(AllText.helpline,
                    style: TextStyle(color: Colors.green, fontSize: 10)),
              ))
        ],
      ),
      onPressed: () {
        launchUrl(Uri.parse("tel:+880${value.noticeAndContract[0]['helpline']}"));
      },
    ),

    );
  }
}


