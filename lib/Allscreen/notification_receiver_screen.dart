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
        backgroundColor:  Colors.green,
        title: const Text("Notification"),
      ),
      body: Consumer<HomeScreenProvider>(
        builder: (context, value, child) => value.notificationMap!.isEmpty ?
             const Center(child: Text("No Notification"),)
            : ListView.builder(
                itemCount: value.notificationMap?.length ?? 0,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 15),
                      child: ListTile(
                        onTap: () => StockOutPopUp.showStockOutPopup(
                          context,
                          "${value.notificationMap?['title']}",
                          Text("${value.notificationMap?['body']}"),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        tileColor:  Colors.green.withOpacity(0.3),
                        leading: const Icon(Icons.notifications),
                        title: Text("${value.notificationMap?['title']}",style: const TextStyle(fontWeight: FontWeight.bold),),
                        subtitle: Text("${value.notificationMap?['body']}"),
                      ),
                    )),
      ),
    );
  }
}
