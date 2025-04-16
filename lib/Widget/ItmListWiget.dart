import 'package:flutter/material.dart';
import 'package:gamestopup/AllText.dart';
import 'package:gamestopup/Controller/Provider/CheckoutProvider.dart';
import 'package:gamestopup/Controller/Provider/ItemListWidgetProvider.dart';
import 'package:gamestopup/Model/ProductListModel.dart';
import 'package:provider/provider.dart';

class ItemListWidget {
  static Widget itemListWidget(
      BuildContext context, List itemsList, String name, String img) {
    List<ProductListModel> pList = itemsList.map((element) => ProductListModel.fromList(element)).toList();

    // Define a professional color palette
    const Color primaryColor = Color(0xFF1E88E5);  // A professional blue
    const Color accentColor = Color(0xFFFFA000);   // A warm accent color
    const Color backgroundColor = Color(0xFFF5F5F5); // Light gray background
    const Color textColor = Color(0xFF333333);     // Dark gray for text
    const Color selectedColor = Color(0xFF00695C); // A deep teal for selected items

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double maxWidth = constraints.maxWidth;
        int crossAxisCount = maxWidth > 600 ? 4 : 2;
        double itemHeight = maxWidth > 600 ? 70 : 55;

        return Container(
          padding: EdgeInsets.all(maxWidth * 0.02),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: backgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: maxWidth * 0.05,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: itemsList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisExtent: itemHeight,
                  crossAxisSpacing: maxWidth * 0.02,
                  mainAxisSpacing: maxWidth * 0.02,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      var data = Provider.of<CheckOutProvider>(context, listen: false);
                      var selectedIndex = Provider.of<ItemListWidgetProvider>(context, listen: false);
                      data.productPrice = pList[index].price;
                      data.productName = pList[index].name;
                      data.brandName = name;
                      selectedIndex.changeSelectSystem(index, pList[index].price);
                      data.paymentNumberController.text = '';
                      data.trxIdController.text = '';
                      data.checkOutResult.clear();
                      data.selectedIndex = 0;
                    },
                    child: Consumer<ItemListWidgetProvider>(
                      builder: (context, value, child) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: index == value.selectedIndex ? selectedColor : primaryColor),
                          color: index == value.selectedIndex ? selectedColor : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.02),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                pList[index].name,
                                style: TextStyle(
                                  color: index == value.selectedIndex ? Colors.white : textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              Text(
                                "${AllText.currencySymbol}${pList[index].price}",
                                style: TextStyle(
                                  fontSize: maxWidth * 0.03,
                                  color: index == value.selectedIndex ? Colors.white70 : accentColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}