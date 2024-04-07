import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gamestopup/AllApiUrl/ApiEndpoint.dart';
import 'package:gamestopup/AllText.dart';
import 'package:gamestopup/Controller/Provider/CheckoutProvider.dart';
import 'package:gamestopup/Widget/PaymentdataShow.dart';
import 'package:provider/provider.dart';


class PaymentSection {
  Widget paymentSection(String price, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        const Center(
          child: Text(
            AllText.paymentText,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
        ),
        const SizedBox(
          height: 10,
        ),
        Provider.of<CheckOutProvider>(context).paymentList.isNotEmpty
            ? Consumer<CheckOutProvider>(
              builder: (context, value, child) => GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.paymentList.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 95),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      value.paymentUpdate(index);
                    },
                    child: Column(
                      children: [
                        Card(
                          elevation: 10,
                          shadowColor: Colors.green,
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.green),
                                color: index == value.selectedIndex
                                    ? Colors.black
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                    "${ApiEndPoint.mainUrl}/${value.paymentList[index].img}",
                                    height: 40,
                                    width: 40,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                            ),
                                          ),
                                        ),
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                  ),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  value
                                      .paymentList[index].paymentName,
                                  style: TextStyle(
                                      color:
                                      index == value.selectedIndex
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        index == value.selectedIndex
                            ? const Icon(
                          Icons.arrow_downward,
                          color: Colors.green,
                        )
                            : const Text(''),
                      ],
                    ),
                  );
                },
              ),
            )
            : const CircularProgressIndicator(),
        Provider.of<CheckOutProvider>(context).selectedIndex != -1
            ? PaymentData().paymentData(context, price)
            : const Text(''),
      ],
    );
  }
}
