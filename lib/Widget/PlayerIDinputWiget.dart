import 'package:flutter/material.dart';
import 'package:gamestopup/AllText.dart';
import 'package:gamestopup/Controller/Provider/CheckoutProvider.dart';
import 'package:gamestopup/PriceConvertor.dart';
import 'package:provider/provider.dart';



class PlayerIdInputWidget {

 Widget playerIdInputWidget(BuildContext context, String price, inputName ) {
    return Column(
      children: [
        Text(price.isNotEmpty ? "${AllText.currencySymbol} ${PriceConvertor.convertPrice(price)} ${AllText.currency}" : '',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        const SizedBox(height: 15),
         Text(inputName ?? '',
            style: const TextStyle(
              fontSize: 16,
            )),
        Card(
          elevation: 10,
          shadowColor: Colors.green,
          surfaceTintColor: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.green, // Adjust border color if needed
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              // Adjust padding as needed
              child: TextField(
                controller:
                    Provider.of<CheckOutProvider>(context).playerIdController,
                decoration:  InputDecoration(
                  hintText: inputName ?? '',
                  border: InputBorder.none, // Remove default border
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
