import 'package:flutter/material.dart';
import 'package:gamestopup/AllText.dart';
import 'ProfileInfoItem.dart';

class ProfileInfoRow extends StatelessWidget {
  int totalOrder;
  int completeOrder;
  int pendingOrder;

  ProfileInfoRow({
    Key? key,
    required this.completeOrder,
    required this.pendingOrder,
    required this.totalOrder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ProfileInfoItem> items = [
      ProfileInfoItem(AllText.profileOrderTextList[0], totalOrder),
      ProfileInfoItem(AllText.profileOrderTextList[1], completeOrder),
      ProfileInfoItem(AllText.profileOrderTextList[2], pendingOrder),
    ];

    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: items.map((item) => _singleItem(context, item)).toList(),
      ),
    );
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          item.value.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      Text(
        item.title,
        //style: Theme.of(context).textTheme.bodyText2,
      ),
    ],
  );
}