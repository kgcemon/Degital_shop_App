import 'dart:convert';

import 'package:gamestopup/Model/profileModel.dart';
import 'package:http/http.dart' as http;

import '../../Controller/SharedPreferencesInstance.dart';
import '../ApiEndpoint.dart';

class ShowProfileOrderApi {
  static Future<List<ProfileModel>> showProfileOrder() async {
    String myOrderKay = 'myorder';
    List<ProfileModel> myFullData = [];
    if (await SharedPreferencesInstance.sharedPreferencesGet(myOrderKay) ==
        null) {
      http.Response response = await http
          .post(Uri.parse(ApiEndPoint().profileOrderShowUrl), body: {
        "user_id": await SharedPreferencesInstance.sharedPreferencesGet('id')
      });
      Map body = jsonDecode(response.body);
      List myList = body['data'];
      await SharedPreferencesInstance.sharedPreferencesSet(
          myOrderKay, jsonEncode(myList));
      for (var element in myList) {
        myFullData.add(ProfileModel.fromJson(element));
      }
      return myFullData;
    } else {
      List myList = jsonDecode(await SharedPreferencesInstance.sharedPreferencesGet(myOrderKay));
      print(myList);
      for (var element in myList) {
        myFullData.add(ProfileModel.fromJson(element));
      }
      return myFullData;
    }
  }
}
