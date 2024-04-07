import 'package:flutter/material.dart';
import 'package:gamestopup/AllApiUrl/Api/CheckOutApi.dart';
import 'package:gamestopup/AllApiUrl/Api/PlaceOrderApi.dart';
import 'package:gamestopup/Controller/SharedPreferencesInstance.dart';
import 'package:gamestopup/Model/OrderSucessModel.dart';
import 'package:gamestopup/Model/PaymentModel.dart';


class CheckOutProvider extends ChangeNotifier {
  CheckOutProvider() {
    loadAll();
    notifyListeners();
  }

  TextEditingController playerIdController = TextEditingController();
  TextEditingController paymentNumberController = TextEditingController();
  TextEditingController trxIdController = TextEditingController();
  String productName = '';
  String productPrice = '';
  String brandName = '';
  String playerId = '';
  int selectedIndex = 0;
  List<PaymentModel> paymentList = [];
  List<OrderSuccessModel> checkOutResult = [];
  String trxId = '';

  loadAll() async {
    paymentList = (await CheckOutApi.loadPaymentList());
    //playerId = (await CheckOutApi.loadPlayerIdName(playerIdController.text))!;
    notifyListeners();
  }

  paymentUpdate(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  placeOrder(BuildContext context) async {
  try{
    if (paymentNumberController.text.isNotEmpty &&
        trxIdController.text.isNotEmpty &&
        playerIdController.text.isNotEmpty) {
      checkOutResult = await PlaceOrderApi.getOrderResult(
        context,
        await SharedPreferencesInstance.sharedPreferencesGet('name'),
        await SharedPreferencesInstance.sharedPreferencesGet('phone'),
        await SharedPreferencesInstance.sharedPreferencesGet('id'),
        paymentNumberController.text,
        trxIdController.text,
        playerIdController.text,
        "$brandName ' ' $productName",
        productPrice,
        productPrice,
        await SharedPreferencesInstance.sharedPreferencesGet("token"),
      );
      notifyListeners();
    }
  }catch(e){
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("সমস্যা হচ্ছে যোগাযো করুন")));
  }
  }

  trxIdError(String txt)async{
    trxId = txt;
    notifyListeners();
  }
}
