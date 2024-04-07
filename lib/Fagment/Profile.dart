import 'package:flutter/material.dart';
import 'package:gamestopup/AllText.dart';
import 'package:gamestopup/Controller/Provider/Profile_Provider.dart';
import 'package:gamestopup/Widget/MyOrderWidget.dart';
import 'package:provider/provider.dart';
import '../Widget/ProfileInfoItem.dart';
import '../Widget/ProfileInfoRow.dart';

class ProfilePage1 extends StatelessWidget {
  const ProfilePage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var data = Provider.of<ProfileProvider>(context);
    data.load();
    var processingOrders = data.myOrder.where((element) => element.status == "Processing").toList();
    int processingOrdersLength = processingOrders.length;
    var completeOrders = data.myOrder.where((element) => element.status == "Complete").toList();
    int completeOrdersLength = completeOrders.length;
    return Expanded(
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: TopPortion(),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    data.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(data.phone),
                  const SizedBox(height: 10),
                  ProfileInfoRow(completeOrder: completeOrdersLength,
                      pendingOrder: processingOrdersLength,
                      totalOrder: data.myOrder.length),
                   Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(AllText.bottomNavigationBarItemTextProfile,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        Expanded(child: MyOrderWidget.myOrderWidget(context)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



