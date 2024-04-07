import 'dart:convert';
import 'package:gamestopup/Model/PaymentModel.dart';
import 'package:http/http.dart' as http;
import '../ApiEndpoint.dart';

class CheckOutApi {
  static Future<List<PaymentModel>> loadPaymentList() async {
    List<PaymentModel> myList = [];

    try {
      http.Response response =
          await http.get(Uri.parse(ApiEndPoint().paymentLoadUrl));
      List loadList = jsonDecode(response.body);
      for (var element in loadList) {
        myList.add(PaymentModel.fromJson(element));
      }
    } catch (error) {
      return myList;
    }

    return myList;
  }

  static Future<String?> loadPlayerIdName(String playerID) async {
    try {
      http.Response response =
          await http.get(Uri.parse(ApiEndPoint().playerIDUrl + playerID));
      var body = jsonDecode(response.body);
      var idName = body['Player_Name'];
      return idName;
    } catch (error) {
      return null;
    }
  }
}
