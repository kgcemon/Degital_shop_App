import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamestopup/AllText.dart';
import 'package:gamestopup/AllimagesLocation.dart';
import 'package:gamestopup/Controller/Provider/CheckoutProvider.dart';
import 'package:gamestopup/PriceConvertor.dart';
import 'package:gamestopup/Widget/CheckOutPageInput.dart';
import 'package:gamestopup/Widget/StockOutPopUp.dart';
import 'package:provider/provider.dart';
import '../Controller/CheckOutPageBottomController.dart';

class PaymentData {
  Widget paymentData(BuildContext context, String price) {
    var paymentProvider = Provider.of<CheckOutProvider>(context);

    void copyToClipboard(String text) {
      Clipboard.setData(ClipboardData(text: text));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AllText.numberCopyText)),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final isWideScreen = maxWidth > 600;

        return Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(isWideScreen ? 20.0 : 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTotalAmount(price),
                SizedBox(height: isWideScreen ? 20 : 15),
                _buildPaymentNumber(paymentProvider, copyToClipboard),
                SizedBox(height: isWideScreen ? 20 : 15),
                _buildPaymentInfo(paymentProvider, isWideScreen,context),
                SizedBox(height: isWideScreen ? 30 : 20),
                _buildCheckoutButton(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentNumber(CheckOutProvider provider, Function(String) copyToClipboard) {
    return InkWell(
      onTap: () => copyToClipboard(provider.paymentList[provider.selectedIndex].number),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${AllText.numberText}: ${provider.paymentList[provider.selectedIndex].number}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10,),
          const Icon(Icons.copy, size: 20, color: Colors.blue),
        ],
      ),
    );
  }

  Widget _buildTotalAmount(String price) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green.shade200),
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            "${AllText.total} ${PriceConvertor.convertPrice(price)}${AllText.currencySymbol} পেমেন্ট করুন",
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentInfo(CheckOutProvider provider, bool isWideScreen, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isWideScreen ? 20.0 : 15.0),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            provider.paymentList[provider.selectedIndex].info,
            style: TextStyle(fontSize: isWideScreen ? 14 : 12, color: Colors.green.shade800),
          ),
          SizedBox(height: isWideScreen ? 20 : 15),
          _buildInputField(
            controller: provider.paymentNumberController,
            label: AllText.paymentControllerText,
            icon: Icons.phone,
          ),
          SizedBox(height: isWideScreen ? 15 : 10),
          _buildTransactionIdSection(context),
          SizedBox(height: isWideScreen ? 15 : 10),
          _buildInputField(
            controller: provider.trxIdController,
            label: AllText.transactionID,
            icon: Icons.featured_play_list_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return CheckoutInput.checkoutInput(
      TextInputType.text,
      controller,
      label,
      Icon(icon, color: Colors.green),
    );
  }

  Widget _buildTransactionIdSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () => StockOutPopUp.showStockOutPopup(
            context,
            AllText.transactionID,
            Column(
              children: [
                const Text(
                  "টাকা সেন্ড মানি করার পর আপনি আপনার ট্রানজেকশন আইডি পেয়ে যাবেন",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Image.asset(ImagesLocation.bktrxpic),
              ],
            ),
          ),
          child: const Text(
            AllText.transactionIDText,
            style: TextStyle(fontSize: 12, color: Colors.pink, decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => CheckOutPageController.orderCheckOut(context),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 46),
        backgroundColor: const Color(0xff0D6EFC),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 15),
      ),
      child: const Text(
        AllText.checkOutOrderPlaceText,
        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}