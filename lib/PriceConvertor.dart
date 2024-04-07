import 'package:gamestopup/AllText.dart';

abstract class PriceConvertor{
  static String convertPrice(String price){
    List<String> bnNumber = AllText.priceConvertBanglaNumber;
    List<String> enNumber = AllText.priceConvertEnglishNumber;
    for(int a=0; a<bnNumber.length; a++){
      price = price.replaceAll(enNumber[a], bnNumber[a]);
    }
    return price;
  }
}