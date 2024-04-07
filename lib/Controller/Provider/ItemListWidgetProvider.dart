import 'package:flutter/cupertino.dart';

class ItemListWidgetProvider extends ChangeNotifier{

  int selectedIndex = -1;
  String selectedPrice = '';

  changeSelectSystem(int index, String price){
    selectedIndex = index;
    selectedPrice = price;
    notifyListeners();
  }



}