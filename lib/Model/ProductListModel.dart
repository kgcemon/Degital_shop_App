class ProductListModel{
  String name;
  String price;
  ProductListModel({required this.name, required this.price});

  factory ProductListModel.fromList(Map json){
    return ProductListModel(
        name: json['name'] ?? '',
        price: json['price'] ?? '',
    );
  }
}