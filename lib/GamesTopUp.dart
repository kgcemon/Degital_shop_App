import 'package:flutter/material.dart';
import 'Allscreen/auth/splash_screen.dart';

class GamesTopUp extends StatelessWidget {
  const GamesTopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff0D6EFC),
          scaffoldBackgroundColor: Colors.white,fontFamily: 'BenSen'),
      home: const SplashScreen(),);
  }
}