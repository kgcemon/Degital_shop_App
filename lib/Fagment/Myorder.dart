import 'package:flutter/material.dart';
import 'package:gamestopup/Widget/MyOrderWidget.dart';

class MyOrder extends StatelessWidget {
  const MyOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: MyOrderWidget.myOrderWidget(context));
  }
}
