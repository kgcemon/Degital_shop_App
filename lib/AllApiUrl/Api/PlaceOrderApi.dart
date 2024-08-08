import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamestopup/AllApiUrl/ApiEndpoint.dart';
import 'package:gamestopup/Model/OrderSucessModel.dart';
import 'package:http/http.dart' as http;

class PlaceOrderApi {
  static Future<List<OrderSuccessModel>> getOrderResult(
      BuildContext context,
      String username,
      number,
      userId,
      bkashNumber,
      trxid,
      userdata,
      itemtitle,
      total,
      productPrice,
      token) async {
    try {
      List<OrderSuccessModel> result = [];
      http.Response response = await http.post(
        Uri.parse(ApiEndPoint().orderPlaceUrl),
        body: {
          "username": username,
          "number": number,
          "status": 'Processing',
          "user_id": userId,
          "bkash_number": bkashNumber,
          "trxid": trxid,
          "userdata": userdata,
          "itemtitle": itemtitle,
          "total": total,
          "token": token,
        },
      );
      List myall = jsonDecode(response.body);
        for (var element in myall) {
          result.add(OrderSuccessModel.fromJson(element));
        }
        print(result);
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
