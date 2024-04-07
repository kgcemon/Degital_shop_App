import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

loginLoading(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => const CupertinoActivityIndicator(color: Colors.green),
  );
}
