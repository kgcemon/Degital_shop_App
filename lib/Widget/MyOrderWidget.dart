import 'package:flutter/material.dart';
import 'package:gamestopup/AllText.dart';
import 'package:gamestopup/Controller/Provider/Profile_Provider.dart';
import 'package:gamestopup/Controller/SharedPreferencesInstance.dart';
import 'package:gamestopup/PriceConvertor.dart';
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
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: ExpansionTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.green[100],
                  collapsedBackgroundColor: Colors.green[100],
                  title: ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    leading: CircleAvatar(
                      backgroundColor: Colors.green[600],
                      child: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            PriceConvertor.convertPrice(
                                value.myOrder[index].id.toString()),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      value.myOrder[index].itemtitle,
                      style: const TextStyle(color: Colors.green),
                    ),
                    subtitle: Text(
                      value.myOrder[index].status,
                      style: const TextStyle(color: Colors.green),
                    ),
                  ),
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildOrderDetailRow(
                              AllText.statusText, value.myOrder[index].status),
                          buildOrderDetailRow(AllText.orderNumberText,
                              value.myOrder[index].id.toString()),
                          buildOrderDetailRow(AllText.productText,
                              value.myOrder[index].itemtitle),
                          buildOrderDetailRow(AllText.userDataText,
                              value.myOrder[index].userdata),
                          buildOrderDetailRow(AllText.numberText,
                              value.myOrder[index].bkash_number),
                          buildOrderDetailRow(AllText.trxIDText,
                              value.myOrder[index].trxid),
                          const SizedBox(height: 8),
                          Text(
                            "${AllText.totalText} ${PriceConvertor.convertPrice(value.myOrder[index].total)} ${AllText.currencySymbol}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.green[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }

  static Widget buildOrderDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.green[700],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.green[700],
              ),
            ),
          ),
        ],
      ),
    );
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
