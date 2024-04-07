import 'package:flutter/material.dart';
import 'package:gamestopup/Controller/Provider/CheckoutProvider.dart';
import 'package:provider/provider.dart';
import '../AllText.dart';
import '../Allscreen/ChackoutPage.dart';

class OrderNowBottomController{

  static myOrderNowBottomController(BuildContext context){
    var checkOutProviders = Provider.of<CheckOutProvider>(context,listen: false);
    checkOutProviders.loadAll();
    if (checkOutProviders.playerIdController.text.length > 2 &&
        checkOutProviders.productPrice.isNotEmpty &&
        checkOutProviders.productName.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CheckOutPage(
            productName: checkOutProviders.productName,
            productPrice: checkOutProviders.productPrice,
            brandName: checkOutProviders.brandName,
          ),
        ),
      );
    } else if (checkOutProviders.playerIdController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(microseconds: 300000),
          content: Text(AllText.inputTextScaffoldMsg)));
    } else if (checkOutProviders.productName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(microseconds: 300000),
          content: Text(AllText.productSelectWarning)));
    }
  }

}