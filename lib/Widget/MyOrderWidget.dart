import 'package:flutter/material.dart';
import 'package:gamestopup/AllText.dart';
import 'package:gamestopup/Controller/Provider/Profile_Provider.dart';
import 'package:gamestopup/Controller/SharedPreferencesInstance.dart';
import 'package:gamestopup/PriceConvertor.dart';
import 'package:gamestopup/Widget/StockOutPopUp.dart';
import 'package:provider/provider.dart';


class MyOrderWidget {
  static Widget myOrderWidget(BuildContext context) {
    load(context);
    return RefreshIndicator(
        onRefresh: () async {
          var data = Provider.of<ProfileProvider>(context, listen: false);
          await SharedPreferencesInstance.sharedPreferencesRemove('myorder');
          return data.loadProfileOrder();
        },
        child: Consumer<ProfileProvider>(
          builder: (context, value, child) => ListView.builder(
            itemCount: value.myOrder.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: ListTile(
                  onTap: () => StockOutPopUp.showStockOutPopup(
                    context,
                    AllText.orderInfoText,
                    PopUpCard.myPopUp(value.myOrder, index),
                  ),
                  trailing: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: const Text(
                        AllText.viewText,
                        style: TextStyle(color: Colors.green),
                      )),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: FittedBox(
                      child: Text(
                        PriceConvertor.convertPrice(
                            value.myOrder[index].id.toString()),
                        style: const TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                  title: Text(value.myOrder[index].itemtitle,
                      style: const TextStyle(color: Colors.white)),
                  subtitle: Row(children: [
                    Text(
                      value.myOrder[index].status,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ]),
                ),
              );
            },
          ),
        ));
  }
}

class PopUpCard {
  static myPopUp(List myList, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${AllText.statusText} ${myList[index].status}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.green[800], // Dark green text color
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "${AllText.orderNumberText} ${myList[index].id}",
          style: TextStyle(fontSize: 16, color: Colors.green[700]),
        ),
        Text(
          "${AllText.productText} ${myList[index].itemtitle}",
          style: TextStyle(fontSize: 16, color: Colors.green[700]),
        ),
        Text(
          "${AllText.userDataText} ${myList[index].userdata}",
          style: TextStyle(fontSize: 16, color: Colors.green[700]),
        ),
        Text(
          "${AllText.numberText} ${myList[index].bkash_number}",
          style: TextStyle(fontSize: 16, color: Colors.green[700]),
        ),
        Text(
          "${AllText.trxIDText} ${myList[index].trxid}",
          style: TextStyle(fontSize: 16, color: Colors.green[700]),
        ),
        const SizedBox(height: 8),
        Text(
          "${AllText.totalText} ${PriceConvertor.convertPrice(myList[index].total)} ${AllText.currencySymbol}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.green[800],
          ),
        ),
      ],
    );
  }
}

load(BuildContext context) async {
  var data = Provider.of<ProfileProvider>(context, listen: false);
  await SharedPreferencesInstance.sharedPreferencesRemove('myorder');
  await data.loadProfileOrder();
}
