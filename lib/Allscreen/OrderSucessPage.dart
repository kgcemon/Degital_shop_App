import 'package:flutter/material.dart';
import 'package:gamestopup/AllText.dart';
import 'package:gamestopup/Allscreen/HomeScreen.dart';
import 'package:gamestopup/Controller/Provider/CheckoutProvider.dart';
import 'package:gamestopup/PriceConvertor.dart';
import 'package:gamestopup/Widget/MyAppBar.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../Controller/Provider/admob_controller_provider.dart';

class OrderSucessPage extends StatelessWidget {
  const OrderSucessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.myAppBar(context: context, titleWidget: const Text("Thank You")),
      body: Column(children: [
        Consumer<CheckOutProvider>(
          builder: (context, value, child) => value.checkOutResult.isEmpty
              ? const Center(
                  child: Center(child: CircularProgressIndicator()),
                )
              : const SizedBox(
                  height: 20,
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Card(
            elevation: 8,
            surfaceTintColor: Colors.white,
            color: Colors.white,
            child: Center(
              child: Consumer<CheckOutProvider>(
                  builder: (context, value, child) => value
                          .checkOutResult.isEmpty
                      ? const Text('')
                      : value.checkOutResult[0].status == "sucess"
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: value.checkOutResult.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.done_outline_sharp,
                                            color: Colors.green, size: 70),
                                        const Text(AllText.ssInfoText,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 10),
                                        Demo(
                                          title: AllText.orderIdText,
                                          data: PriceConvertor.convertPrice(
                                              value.checkOutResult[index].id),
                                          icon: Icons.info,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Demo(
                                          title: AllText.orderGo,
                                          data: value
                                              .checkOutResult[index].userdata,
                                          icon:
                                              Icons.production_quantity_limits,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Demo(
                                          title: AllText.paymentDataText,
                                          data: value.checkOutResult[index]
                                              .bkashNumber,
                                          icon: Icons.monetization_on_sharp,
                                        ),
                                        const SizedBox(height: 5),
                                        Demo(
                                          title: AllText.transactionID,
                                          data:
                                              value.checkOutResult[index].trxid,
                                          icon: Icons.info,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Demo(
                                          title: AllText.total,
                                          data: PriceConvertor.convertPrice(
                                              "${value.checkOutResult[index].total} ${AllText.currency}"),
                                          icon: Icons
                                              .do_not_disturb_on_total_silence,
                                        ),
                                        const SizedBox(height: 10),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomeScreen(),
                                                ));
                                          },
                                          child: const Text(
                                              AllText.backToHomeText,
                                              style: TextStyle(
                                                  color: Colors.green)),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : Text(value.checkOutResult[0].status)),
            ),
          ),
        ),
        const SizedBox(height: 15,),
        Consumer<AdmobAdsController>(builder:
            (context, value, child) =>
        value.nativeAdIsLoaded == true ?  SizedBox(height: 120,
          width: double.infinity,
          child: AdWidget(ad: value.bannerAd!),
        ) : const Text("Loading Ads"),
        ),
      ]),
    );
  }
}

class Demo extends StatelessWidget {
  String title;
  String data;
  IconData icon;

  Demo(
      {super.key, required this.title, required this.data, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.green,
      elevation: 15,
      child: ColoredBox(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: Colors.green),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: FittedBox(
                        child: Text(
                      title,
                    )),
                  ),
                ],
              ),
              FittedBox(
                child: Text(data,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: data.length > 10 ? 10 : 15)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
