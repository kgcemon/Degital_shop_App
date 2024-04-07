class PaymentModel{

  String paymentName;
  String number;
  String info;
  String img;

  PaymentModel({
    required this.img,
    required this.info,
    required this.number,
    required this.paymentName});

  factory PaymentModel.fromJson(Map<String, dynamic> json){
    return PaymentModel(
        img: json['img'],
        info: json['info'],
        number: json['number'],
        paymentName: json['payment_name']
    );
  }

}