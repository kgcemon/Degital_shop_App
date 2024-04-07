import 'package:flutter/material.dart';
import 'package:gamestopup/AllText.dart';
import 'package:gamestopup/Controller/Provider/CheckoutProvider.dart';
import 'package:gamestopup/Controller/Provider/ItemListWidgetProvider.dart';
import 'package:gamestopup/Model/PopularItemModel.dart';
import 'package:provider/provider.dart';
import '../Allscreen/Details_Page.dart';
import '../Widget/StockOutPopUp.dart';

class PopularBottomController {
  static myBottom(
      int index, List<PopularItemsModel> allItems, BuildContext context) {
    if (allItems[index].stock == 'yes') {
      var itemListWidgetProvider =
          Provider.of<ItemListWidgetProvider>(context, listen: false);
      var chackoutProvider =
          Provider.of<CheckOutProvider>(context, listen: false);
      chackoutProvider.productName = '';
      chackoutProvider.playerId = '';
      chackoutProvider.productPrice = '';
      chackoutProvider.playerIdController.text = '';
      itemListWidgetProvider.selectedIndex = -1;
      itemListWidgetProvider.selectedPrice = "";
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(
              itemsList: allItems[index].allItems,
              productName: "${allItems[index].categoryName}",
              img: allItems[index].ctaImg.toString(),
              inputName: allItems[index].inputName,
            ),
          ));
    } else {
      StockOutPopUp.showStockOutPopup(
          context, AllText.stockOutTitle, const Text(AllText.stockOutText,textAlign: TextAlign.center),);
    }
  }
}
