import 'dart:convert';
import 'package:gamestopup/Controller/SharedPreferencesInstance.dart';
import 'package:http/http.dart' as http;
import '../ApiEndpoint.dart';

class SliderImagesLoad {
  static Future<List<dynamic>> sliderImagesLoadApi() async {
    String url = ApiEndPoint().sliderUrl;
    String sKey = 'slider';
    List<dynamic> myList = [];
    if ((await SharedPreferencesInstance.sharedPreferencesGet(sKey)) == null) {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        SharedPreferencesInstance.sharedPreferencesSet(sKey, response.body);
        myList = jsonDecode(response.body);}
    } else {
      myList = jsonDecode(await SharedPreferencesInstance.sharedPreferencesGet(sKey));}
    return myList;
  }
}
