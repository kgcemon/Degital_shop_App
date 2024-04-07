import 'dart:convert';
import 'package:gamestopup/Controller/SharedPreferencesInstance.dart';
import 'package:http/http.dart' as http;
import '../../Model/PopularItemModel.dart';
import '../ApiEndpoint.dart';

class PopularItemsApi {
  static Future<List<PopularItemsModel>> loadPopularItems() async {
    List<PopularItemsModel> myList = [];
    String itemKey = 'item';
    try {
      String url = ApiEndPoint().popularItems;
      if (await SharedPreferencesInstance.sharedPreferencesGet(itemKey) ==
          null) {
        http.Response response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          SharedPreferencesInstance.sharedPreferencesSet(
              itemKey, response.body);
          List<dynamic> myData = jsonDecode(response.body);
          myList = myData
              .map((element) => PopularItemsModel.fromJson(element))
              .toList();
          return myList;
        } else {
          //print('Error loading popular items: ${response.statusCode}');
          return [];
        }
      } else {
        List<dynamic> myData = jsonDecode(
            await SharedPreferencesInstance.sharedPreferencesGet(itemKey));
        myList = myData
            .map((element) => PopularItemsModel.fromJson(element))
            .toList();
        return myList;
      }
    } catch (e) {
      //print('Error loading popular items: $e');
      return [];
    }
  }
}
