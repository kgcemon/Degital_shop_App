import 'package:flutter/material.dart';
import 'package:gamestopup/Controller/OrderNowBottomController.dart';
import '../AllText.dart';


class  BottomNavBottom{
 Widget bottomNavBottom(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 10,
              minimumSize: const Size(double.infinity, 55),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              shadowColor: Colors.green,
              disabledBackgroundColor: Colors.yellow,
              surfaceTintColor: Colors.transparent,
              backgroundColor: Colors.green),
          onPressed: () {
            OrderNowBottomController.myOrderNowBottomController(context);
          },
          child: const Text(
            AllText.checkOutOrderText,
            style: TextStyle(color: Colors.white, fontSize: 20),
          )),
    );
  }
}
