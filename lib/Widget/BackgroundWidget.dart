import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Lottie.asset("Images/bg.json",
            fit: BoxFit.fill, height: double.infinity, width: double.infinity),
        SafeArea(child: child)
      ],
    );
  }
}
