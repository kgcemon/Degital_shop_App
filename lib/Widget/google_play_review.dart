import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GooglePlayReview {
  static googlePlayReviewDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Column(children: [
        CupertinoAlertDialog(
          title: const Text("Give a Review"),
          content: const Text(
              "আমাদের এ্যাপের সার্ভিস যদি আপনাদের ভালো লাগে একটি রিভিঊ দিন"),
          actions: [
            TextButton(onPressed: () {}, child: const Text("Ok")),
            TextButton(onPressed: () {
              Navigator.pop(context);
            }, child: const Text("Cancel"))
          ],
        )
      ]),
    );
  }
}
