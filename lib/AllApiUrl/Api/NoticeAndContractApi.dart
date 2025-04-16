import 'dart:convert';

import 'package:gamestopup/AllApiUrl/ApiEndpoint.dart';
import 'package:gamestopup/Controller/SharedPreferencesInstance.dart';
import 'package:http/http.dart' as http;

class NewsAndContractApi {
  Future<List> newsAndContractApi() async {
    List myList = [];
    if (await SharedPreferencesInstance.sharedPreferencesGet("contract") ==
        null) {
      try {
        http.Response response =
            await http.get(Uri.parse(ApiEndPoint().noticeAndContractUrl));
        if (response.statusCode == 200) {
          myList = await jsonDecode(response.body);
          await SharedPreferencesInstance.sharedPreferencesSet(
              "contract", jsonEncode(myList));
        } else {
          print('Error: ${response.statusCode}');
        }
      } catch (e) {
      }
    } else {
      myList =  jsonDecode(await SharedPreferencesInstance.sharedPreferencesGet("contract"));
    }
    return myList;
  }
}
