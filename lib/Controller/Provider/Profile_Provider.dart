import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gamestopup/AllApiUrl/Api/ShowProfileOrderApi.dart';
import 'package:gamestopup/AllApiUrl/ApiEndpoint.dart';
import 'package:gamestopup/Controller/SharedPreferencesInstance.dart';
import 'package:gamestopup/Model/profileModel.dart';
import 'package:http/http.dart' as http;

class ProfileProvider extends ChangeNotifier {
  ProfileProvider() {
    load();
    loadProfileOrder();
  }

  String name = '';
  String phone = '';
  Map accountResult = {};
  bool loading = true;
  List<ProfileModel> myOrder = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();

  load() async {
    name = await SharedPreferencesInstance.sharedPreferencesGet('name') ?? "";
    phone = await SharedPreferencesInstance.sharedPreferencesGet('phone') ?? "";
    notifyListeners();
  }

  loadProfileOrder() async {
    if (await SharedPreferencesInstance.sharedPreferencesGet('name') != null) {
      myOrder = await ShowProfileOrderApi.showProfileOrder();
    }
    notifyListeners();
  }

  addDataStorege() async {
    await SharedPreferencesInstance.sharedPreferencesSet("login", 'true');
    await SharedPreferencesInstance.sharedPreferencesSet(
        "name", nameController.text);
    await SharedPreferencesInstance.sharedPreferencesSet(
        "phone", phoneController.text);
    notifyListeners();
  }

  createAccount(BuildContext context) async {
    try {
      loading = false;
      notifyListeners();
      http.Response response =
          await http.post(Uri.parse(ApiEndPoint().createAccountUrl), body: {
        "username": nameController.text,
        "phonenumber": phoneController.text,
        "password": passController.text
      });
      var body = jsonDecode(response.body);
      await SharedPreferencesInstance.sharedPreferencesSet('id', body['id']);
      accountResult = body;
      loading = true;
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error in CreateAccount')));
    }
  }

  loginAccount(BuildContext context) async {
    try {
      loading = false;
      notifyListeners();
      accountResult.clear();
      http.Response response = await http
          .post(Uri.parse(ApiEndPoint().loginUrl), body: {
        "phonenumber": phoneController.text,
        "password": passController.text
      });

      Map body = jsonDecode(response.body);

      if (body['status'] == 'success') {
        Map myMap = body['user_data'];
        await SharedPreferencesInstance.sharedPreferencesSet('id', myMap['id']);
        addDataStorege();
      }

      accountResult = body;
      loading = true;
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Error in loginAccount')));
    }
  }


}
