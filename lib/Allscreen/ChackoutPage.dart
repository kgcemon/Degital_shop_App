import 'package:flutter/material.dart';
import 'package:gamestopup/AllText.dart';
import '../Widget/PaymentSelector.dart';

class CheckOutPage extends StatelessWidget {
  final String brandName;
  final String productName;
  final String productPrice;

  const CheckOutPage({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.brandName,
  });

  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(AllText.paymentText),
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
