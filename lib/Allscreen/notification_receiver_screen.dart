import 'package:flutter/material.dart';
import 'package:gamestopup/Controller/Provider/HomeScreenProvider.dart';
import 'package:gamestopup/Widget/StockOutPopUp.dart';
import 'package:provider/provider.dart';

class NotificationReceiverScreen extends StatelessWidget {
  const NotificationReceiverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Notification",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer<HomeScreenProvider>(
        builder: (context, value, child) => value.notificationMap!.isEmpty
            ? const Center(
                child: Text("No Notification"),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () => StockOutPopUp.showStockOutPopup(
                    context,
                    "${value.notificationMap?['title']}",
                    Text("${value.notificationMap?['body']}"),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  tileColor: value.notificationMap!['body']
                          .toString()
                          .contains("ডিলেট")
                      ? Colors.red.shade400
                      : Colors.green.withOpacity(0.3),
                  leading: const Icon(Icons.notifications),
                  title: Text(
                    "${value.notificationMap?['title']}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("${value.notificationMap?['body']}"),
                ),
              ),
      ),
    );
  }
}
