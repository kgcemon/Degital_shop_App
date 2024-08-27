import 'package:flutter/material.dart';
import 'package:gamestopup/Allscreen/HomeScreen.dart';
import 'package:gamestopup/Controller/Provider/HomeScreenProvider.dart';
import 'package:gamestopup/Controller/Provider/Profile_Provider.dart';
import 'package:gamestopup/Widget/StockOutPopUp.dart';
import 'package:provider/provider.dart';

clickRegisterBtnLogic(
    BuildContext context, ProfileProvider value, String errorText) async {
  if (value.phoneController.text.length > 8 &&
      value.nameController.text.length > 3) {
    await value.createAccount(context);
    if (await value.accountResult['status'] == 'success') {
      value.addDataStorege();
      Provider.of<HomeScreenProvider>(context,listen: false).index = 0;
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false);
      }
    } else {
      if (context.mounted) {
        StockOutPopUp.showStockOutPopup(
            context, "Error", Text(value.accountResult['message']));
      }
    }
  } else {
    StockOutPopUp.showStockOutPopup(context, "Error", Text(errorText));
  }
}

clickLoginBtnLogic(
    BuildContext context, ProfileProvider value, String errorText) async {
  if (value.phoneController.text.length > 8 &&
      value.passController.text.length > 2) {
    await value.loginAccount(context); // Add await here
    if (await value.accountResult['status'] == 'success') {
      value.nameController.text = value.accountResult['user_data']['username'];
      if (context.mounted) {
        Navigator.pop(context);
        Provider.of<HomeScreenProvider>(context,listen: false).index = 0;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => true);
        await value.loginAccount(context); // Add await here
      }
    } else {
      if (context.mounted) {
        StockOutPopUp.showStockOutPopup(
          context,
          "Error",
          Text(value.accountResult['message']),
        );
      }
    }
  } else {
    StockOutPopUp.showStockOutPopup(context, "Error", Text(errorText));
  }
}
