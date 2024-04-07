class ApiEndPoint {
  static String mainUrl = 'https://codmshopbd.com/myapp';
  static String securityKey = 'emon';
  String noticeAndContractUrl;
  String popularItems;
  String sliderUrl;
  String newsUrl;
  String playerIDUrl;
  String paymentLoadUrl;
  String orderPlaceUrl;
  String createAccountUrl;
  String profileOrderShowUrl;
  String loginUrl;
  String newsApiUrl;

  ApiEndPoint()
      : popularItems = "$mainUrl/api/item_and_amount_list.php?api_key=$securityKey",
        sliderUrl = "$mainUrl/api/sliderimageshow.php?api_key=$securityKey",
        newsUrl = "$mainUrl/api/newsapi.php?api_key=$securityKey",
        playerIDUrl = "$mainUrl/api/uid.php?id=",
        paymentLoadUrl = "$mainUrl/api/paymentapi.php?api_key=$securityKey",
        orderPlaceUrl = "$mainUrl/api/add_order.php?api_key=$securityKey",
        createAccountUrl = "$mainUrl/api/addaccount.php?api_key=$securityKey",
        profileOrderShowUrl = "$mainUrl/api/showprofileorder.php?api_key=$securityKey",
        loginUrl = "$mainUrl/api/login.php",
        noticeAndContractUrl = "$mainUrl/api/others.php?api_key=$securityKey",
        newsApiUrl = "$mainUrl/newsapi.php";
}
