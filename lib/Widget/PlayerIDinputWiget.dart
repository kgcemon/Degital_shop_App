import 'package:flutter/material.dart';
import 'package:gamestopup/AllText.dart';
import 'package:gamestopup/Controller/Provider/CheckoutProvider.dart';
import 'package:gamestopup/PriceConvertor.dart';
import 'package:provider/provider.dart';



class PlayerIdInputWidget {

 Widget playerIdInputWidget(BuildContext context, String price, inputName ) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
          color: Colors.green.shade200),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5),),
                color: Colors.white),
            child: Text(price.isNotEmpty ? "${AllText.currencySymbol} $price ${AllText.currency}" : '',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ),
           Text(inputName ?? '',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              )),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
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
                  prefixIcon: const Icon(Icons.insert_drive_file_rounded,color: Colors.green,),
                  hintText: inputName ?? '',
                  border: InputBorder.none, // Remove default border
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
