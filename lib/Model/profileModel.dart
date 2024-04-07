class ProfileModel {
  final String id;
  final String status;
  final String username;
  final String user_id;
  final String bkash_number;
  final String trxid;
  final String userdata;
  final String itemtitle;
  final String total;

  ProfileModel({
    required this.id,
    required this.status,
    required this.username,
    required this.user_id,
    required this.bkash_number,
    required this.trxid,
    required this.userdata,
    required this.itemtitle,
    required this.total,
  });

  factory ProfileModel.fromJson(Map<String,dynamic> json){
    return
    ProfileModel(id: json['id'].toString() ?? '',
        status: json['status'] ?? '',
        username: json['username'] ?? '',
        user_id: json['user_id'] ?? '',
        bkash_number: json['bkash_number']?? '',
        trxid: json['trxid'] ?? '',
        userdata: json['userdata'] ?? '',
        itemtitle: json['itemtitle'] ?? '',
        total: json['total']?? '');
  }



}
