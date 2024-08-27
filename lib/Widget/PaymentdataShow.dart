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
    }
    return Card(
      elevation: 10,
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
                  const SnackBar(
                    content: Text(AllText.numberCopyText),
                  ),
                );
              },
              child: Row(
                children: [
                  Text(
                      "${AllText.numberText}: ${paymentProvider.paymentList[paymentProvider.selectedIndex].number}",
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold)),
                  const Icon(
                    Icons.copy,
                    size: 17,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                  color: Colors.green),
              child: Text(
                "${AllText.total} ${PriceConvertor.convertPrice(price)}${AllText.currencySymbol}",
                style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(color: Colors.green.shade200),
              child: Column(
                children: [
                  Text(
                    paymentProvider.paymentList[paymentProvider.selectedIndex].info,
                    style: const TextStyle(fontSize: 12),
                  ),


                  const SizedBox(
                    height: 15,
                  ),
                  CheckoutInput.checkoutInput(
                      TextInputType.number,
                      paymentProvider.paymentNumberController,
                      AllText.paymentControllerText,
                      const Icon(
                        Icons.phone,
                        color: Colors.green,
                      )),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      InkWell(
                        onTap: () => StockOutPopUp.showStockOutPopup(
                          context,
                          AllText.transactionID,
                          Column(
                            children: [
                              const Text(
                                "টাকা সেন্ড মানি করার পর আপনি আপনার ট্রানজেকশন আইডি পেয়ে যাবেন",
                                style: TextStyle(fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                              Image.asset(ImagesLocation.bktrxpic),
                            ],
                          ),
                        ),
                        child: const Text(
                          AllText.transactionIDText,
                          style: TextStyle(fontSize: 8, color: Colors.pink),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CheckoutInput.checkoutInput(
                    TextInputType.text,
                    paymentProvider.trxIdController,
                    AllText.transactionID,
                    const Icon(
                      Icons.featured_play_list_rounded,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                CheckOutPageController.orderCheckOut(context);
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
                height: 55,
                width: double.infinity,
                child: const Text(
                  AllText.checkOutOrderPlaceText,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
