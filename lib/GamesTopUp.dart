import 'package:flutter/material.dart';
import 'Allscreen/splash_screen.dart';

class GamesTopUp extends StatelessWidget {
  const GamesTopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white,fontFamily: 'BenSen'),
      home: const SplashScreen(),);
  }
}