import 'package:flutter/material.dart';
import 'package:gamestopup/AllText.dart';
import 'package:gamestopup/Controller/CheckOutPageBottomController.dart';
import '../Widget/PaymentSelector.dart';

class CheckOutPage extends StatelessWidget {
  String brandName;
  String productName;
  String productPrice;

  CheckOutPage({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.brandName,
  });

  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: () {
          CheckOutPageController.orderCheckOut(context);
        },
        child: Container(
            alignment: Alignment.center,
            color: Colors.green,
            height: 55,
            width: double.infinity,
            child: const Text(
              AllText.checkOutOrderPlaceText,
              style: TextStyle(fontSize: 20,color: Colors.white),
            ),),
      ),
      appBar: AppBar(
        title: const Text(AllText.checkoutPageTitleText),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: PaymentSection().paymentSection(productPrice, context),
        ),
      ),
    );
  }
}
