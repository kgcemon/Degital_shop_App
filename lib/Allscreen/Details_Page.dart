import 'package:flutter/material.dart';
import 'package:gamestopup/Controller/Provider/ItemListWidgetProvider.dart';
import 'package:gamestopup/Widget/ItmListWiget.dart';
import 'package:gamestopup/Widget/MyAppBar.dart';
import 'package:gamestopup/Widget/PlayerIDinputWiget.dart';
import 'package:provider/provider.dart';
import '../Widget/OrderNowNavbotton.dart';

class DetailsPage extends StatelessWidget {
  List itemsList;
  String productName;
  String img;
  String inputName;

  DetailsPage(
      {super.key,
      required this.itemsList,
      required this.productName,
      required this.img,
      required this.inputName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBottom().bottomNavBottom(context),
      appBar: MyAppBar.myAppBar(context: context, titleWidget:         Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 25,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                img,
              ),
            ),
          ),
          Text(productName,
              style:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white)),
        ],
      ),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              ItemListWidget.itemListWidget(
                  context, itemsList, productName, img),
              const SizedBox(
                height: 10,
              ),
              Consumer<ItemListWidgetProvider>(
                builder: (context, value, child) => PlayerIdInputWidget()
                    .playerIdInputWidget(
                        context, value.selectedPrice, inputName),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
