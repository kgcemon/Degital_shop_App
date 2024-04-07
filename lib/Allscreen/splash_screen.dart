import 'package:flutter/material.dart';
import 'package:gamestopup/AllimagesLocation.dart';
import 'package:gamestopup/Allscreen/auth/LoginScreen.dart';
import 'package:gamestopup/Controller/Provider/HomeScreenProvider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../Controller/SharedPreferencesInstance.dart';
import 'HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadDataAndNavigate();
  }

  Future<void> _loadDataAndNavigate() async {
    var data = Provider.of<HomeScreenProvider>(context, listen: false);
    await data.loadAllApiData();
    await data.loadNews();
    setState(() {});
    var loginStatus =
        await SharedPreferencesInstance.sharedPreferencesGet('login');
    if (loginStatus == 'true' && data.allItems.isNotEmpty) {
      if (context.mounted && data.allNews.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    } else {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(ImagesLocation.myLogo, height: 150),
            Lottie.asset("Images/loading.json",height: 70)
          ],
        ),
      ),
    );
  }
}
