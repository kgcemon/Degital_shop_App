import 'package:flutter/material.dart';
import 'package:gamestopup/AllText.dart';
import 'package:gamestopup/Controller/Provider/CheckoutProvider.dart';
import 'package:gamestopup/Controller/Provider/ItemListWidgetProvider.dart';
import 'package:gamestopup/Model/ProductListModel.dart';
import 'package:gamestopup/PriceConvertor.dart';
import 'package:provider/provider.dart';

class ItemListWidget {

 static Widget itemListWidget(BuildContext context, List itemsList, String name, img ) {
    List<ProductListModel> pList = [];
    for (var element in itemsList) {
      pList.add(ProductListModel.fromList(element));
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: name,
              child: SizedBox(
                height: 25,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    img,
                  ),
                ),
              ),
            ),
            Text(name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: itemsList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 55,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                var data =
                    Provider.of<CheckOutProvider>(context, listen: false);
                var selectedIndex = Provider.of<ItemListWidgetProvider>(context,listen: false);
                data.productPrice = pList[index].price;
                data.productName = pList[index].name;
                data.brandName = name;
                selectedIndex.changeSelectSystem(index, pList[index].price);
                data.paymentNumberController.text = '';
                data.trxIdController.text = '';
                data.checkOutResult.clear();
                data.selectedIndex = 0;
              },
              child: Consumer<ItemListWidgetProvider>(builder: (context, value, child) => Card(
                shadowColor: Colors.green,
                elevation: 5,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      color: index == value.selectedIndex
                          ? Colors.black
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(pList[index].name,
                              style: TextStyle(
                                  color: index == value.selectedIndex
                                      ? Colors.white
                                      : Colors.black)),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                "${AllText.currencySymbol}${PriceConvertor.convertPrice(pList[index].price)}",
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.red),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),),
            );
          },
        ),
      ],
    );
  }
}
