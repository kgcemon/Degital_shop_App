import 'package:flutter/material.dart';
import 'package:gamestopup/AllText.dart';

class StockOutPopUp {
  static showStockOutPopup(BuildContext context, title, Widget widget) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Center(
            child: Text(
              title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold,fontFamily: 'BenSen'),
            ),
          ),
          content: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
            child: IntrinsicHeight(
              child: widget,
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 40),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  AllText.stockOutBottomText,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
