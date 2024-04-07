import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamestopup/AllText.dart';
import 'package:gamestopup/AllimagesLocation.dart';
import 'package:gamestopup/Controller/Provider/CheckoutProvider.dart';
import 'package:gamestopup/PriceConvertor.dart';
import 'package:gamestopup/Widget/CheckOutPageInput.dart';
import 'package:gamestopup/Widget/StockOutPopUp.dart';
import 'package:provider/provider.dart';

class PaymentData {
  Widget paymentData(BuildContext context, String price) {
    var paymentProvider = Provider.of<CheckOutProvider>(context);
    void copyToClipboard(String text) {
      Clipboard.setData(ClipboardData(text: text));
    }

    return Card(
      elevation: 15,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                copyToClipboard(paymentProvider
                    .paymentList[paymentProvider.selectedIndex].number);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text(AllText.numberCopyText)));
              },
              child: Row(
                children: [
                  Text(
                      "${AllText.numberText} ${paymentProvider.paymentList[paymentProvider.selectedIndex].number}",
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold)),
                  const Icon(
                    Icons.copy,
                    size: 17,
                  )
                ],
              ),
            ),
            Text(
                "${AllText.total} ${PriceConvertor.convertPrice(price)} ${AllText.currencySymbol}",
                style: const TextStyle()),
            const SizedBox(
              height: 4,
            ),
            Text(
                paymentProvider.paymentList[paymentProvider.selectedIndex].info,
                style: const TextStyle(fontFamily: ''),
                textAlign: TextAlign.start),
            const SizedBox(
              height: 5,
            ),
            const FittedBox(
              child: Text(AllText.paymentNumberTitle,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 5,
            ),
            CheckoutInput.checkoutInput(
                TextInputType.number,
                paymentProvider.paymentNumberController,
                AllText.paymentControllerText),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  AllText.transactionIDT,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () => StockOutPopUp.showStockOutPopup(
                      context,
                      AllText.transactionID,
                      Column(
                        children: [
                          const Text(
                            "টাকা সেন্ড মানি করার পর আপনি আপনার ট্রানজেকশন আইডি পেয়ে যাবেন",
                            textAlign: TextAlign.center,
                          ),
                          Image.asset(ImagesLocation.bktrxpic),
                        ],
                      )),
                  child: const Text(
                    AllText.transactionIDText,
                    style: TextStyle(fontSize: 8, color: Colors.pink),
                  ),
                )
              ],
            ),
            CheckoutInput.checkoutInput(TextInputType.text,
                paymentProvider.trxIdController, AllText.transactionID),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}
