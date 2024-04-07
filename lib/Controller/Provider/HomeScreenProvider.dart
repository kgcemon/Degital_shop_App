import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:gamestopup/AllApiUrl/Api/NoticeAndContractApi.dart';
import 'package:gamestopup/AllApiUrl/Api/PopularItemApi.dart';
import 'package:gamestopup/AllApiUrl/Api/SliderApi.dart';
import 'package:gamestopup/AllApiUrl/ApiEndpoint.dart';
import 'package:gamestopup/Controller/SharedPreferencesInstance.dart';
import 'package:gamestopup/Fagment/Myorder.dart';
import 'package:gamestopup/Fagment/Profile.dart';
import 'package:gamestopup/Model/PopularItemModel.dart';
import 'package:gamestopup/Widget/MyBody.dart';
import 'package:http/http.dart'as http;

class HomeScreenProvider extends ChangeNotifier {
  int index = 0;
  List sliderImagesList = [];
  List<PopularItemsModel> allItems = [];
  int selectedIndex = 0;
  List noticeAndContract = [];
  int review = 0;
  List allNews = [];

  loadAllApiData() async {
    allItems = (await PopularItemsApi.loadPopularItems())!;
    noticeAndContract = (await NewsAndContractApi().newsAndContractApi())!;
    sliderImagesList = (await SliderImagesLoad.sliderImagesLoadApi())!;
    loadNews();
    Future.delayed(const Duration(seconds: 5), () async {
     if(await internetChecker()){
       print("have internet i m working");
       await SharedPreferencesInstance.sharedPreferencesRemove('slider');
       await SharedPreferencesInstance.sharedPreferencesRemove('item');
       await PopularItemsApi.loadPopularItems();
       await SliderImagesLoad.sliderImagesLoadApi();
     }
    });
    notifyListeners();
  }

  bottomNavigationBar(int value) {
    index = value;
    notifyListeners();
  }

  pageChange() {
    if (index == 0) {
      return MyBody.myBody(allItems, sliderImagesList, selectedIndex);
    } else if (index == 2) {
      return const ProfilePage1();
    } else if (index == 1) {
      return const MyOrder();
    }
    notifyListeners();
  }

  categoriesChange(int index) {
    selectedIndex = index;
    notifyListeners();
  }
  
  loadNews()async {
    try{
      http.Response response = await http.get(Uri.parse(ApiEndPoint().newsApiUrl));
      if(response.statusCode == 200) allNews = jsonDecode(response.body);
      print(response.body);
      notifyListeners();
    }catch(e){
      print(e);
    }
  }

  Future<bool> internetChecker() async {
   try{
     final result = await InternetAddress.lookup("google.com");
     if (kDebugMode) {
       print("Have Internet");
     }
     return true;
   } on SocketException{
     if (kDebugMode) {
       print("no Internet");
     }
     return false;
   } catch(e){
     return false;
   }
  }
}
