import 'package:flutter/material.dart';
import 'package:gamestopup/Widget/MyAppBar.dart';
import 'package:http/http.dart' as http;

class FullNews extends StatefulWidget {
  Map fullNewsMap = {};

  FullNews({super.key, required this.fullNewsMap});

  @override
  State<FullNews> createState() => _FullNewsState();
}

class _FullNewsState extends State<FullNews> {
  @override
  void initState() {
    super.initState();
    viewCount();
  }

  viewCount() async {
    String urls =
        "https://codmshopbd.com/myapp/newsViewCount.php?id=${widget.fullNewsMap['id']}";
    http.Response response = await http.get(
      Uri.parse(urls),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.myAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image.network(
                      'https://${widget.fullNewsMap['images'].toString().split("htdocs\/")[1].toString()}',
                      height: 150,
                      width: double.infinity)),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.fullNewsMap['title'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.remove_red_eye),
                      Text(widget.fullNewsMap['views'] ?? 0.toString())
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(widget.fullNewsMap['fullnews'])
            ]),
      ),
    );
  }
}
