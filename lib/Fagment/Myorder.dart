import 'package:flutter/material.dart';
import 'package:gamestopup/Widget/MyOrderWidget.dart';
import '../Allscreen/auth/LoginScreen.dart';
import '../Controller/SharedPreferencesInstance.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  bool isLogged = false;

  @override
  void initState() {
    super.initState();
    _loadDataAndNavigate();
  }

  Future<void> _loadDataAndNavigate() async {
    var loginStatus = await SharedPreferencesInstance.sharedPreferencesGet('login');
    setState(() {
      isLogged = loginStatus == 'true';
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogged) {
      return Expanded(child: MyOrderWidget.myOrderWidget(context));
    } else {
      return const LoginScreen();
    }
  }
}
