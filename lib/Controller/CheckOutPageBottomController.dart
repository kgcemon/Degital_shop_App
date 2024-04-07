import 'package:flutter/material.dart';
import 'package:gamestopup/Allscreen/OrderSucessPage.dart';
import 'package:gamestopup/Controller/Provider/CheckoutProvider.dart';
import 'package:provider/provider.dart';
import '../AllText.dart';

class CheckOutPageController {
  static orderCheckOut(BuildContext context) {
    var checkOutProvider =
        Provider.of<CheckOutProvider>(context, listen: false);
    if (checkOutProvider.playerIdController.text.isNotEmpty &&
        checkOutProvider.trxIdController.text.isNotEmpty &&
        checkOutProvider.paymentNumberController.text.length > 8) {
      checkOutProvider.placeOrder(context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OrderSucessPage(),
          ),);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          content: Text(AllText.errorText),
        ),
      );
    }
  }
}
