import 'dart:convert';

class PopularItemsModel {
  String? categoryName;
  String? ctaImg;
  List allItems;
  String stock;
  String inputName;

  PopularItemsModel({
    required this.categoryName,
    required this.ctaImg,
    required this.allItems,
    required this.stock,
    required this.inputName
  });

  factory PopularItemsModel.fromJson(Map<String, dynamic> json) {
    return PopularItemsModel(
      categoryName: json['catagory_name'] ?? '',
      ctaImg: json['catagory_image'] ?? '',
      allItems: json['amount_list'] != null
          ? List.from(jsonDecode(json['amount_list'],),)
          : [],
      stock: json['stock'] ?? '', inputName: json['inputname'],
    );
  }



}
