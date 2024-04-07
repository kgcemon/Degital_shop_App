class OrderSuccessModel {
  String status;
  String id;
  String username;
  String user_id;
  String bkashNumber;
  String trxid;
  String userdata;
  String itemTitle;
  String total;

  OrderSuccessModel(
      {
      required this.status,
      required this.id,
      required this.total,
      required this.bkashNumber,
      required this.username,
      required this.itemTitle,
      required this.trxid,
      required this.user_id,
      required this.userdata});

  factory OrderSuccessModel.fromJson(Map<String, dynamic> json){
    return OrderSuccessModel(
        id: json['id'] ?? "",
        total: json['total'] ?? "",
        bkashNumber: json['bkash_number'] ?? "",
        username: json['username'] ?? "",
        itemTitle: json['itemtitle'] ?? "",
        trxid: json['trxid'] ??"",
        user_id: json['user_id'] ?? "",
        userdata: json['userdata'] ?? "",
        status: json['status']
    );
  }

}
