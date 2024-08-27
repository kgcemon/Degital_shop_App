import 'package:flutter/material.dart';

loginRegiField(TextEditingController controller, String title, TextInputType inputType,var icons) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(title),
      ),
      const SizedBox(height: 10),
      TextField(
        keyboardType: inputType,
        controller: controller,
        decoration:  InputDecoration(
          prefixIcon: Icon(icons,color: Colors.green,),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
              borderRadius:
              BorderRadius.all(Radius.circular(5))),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
              borderRadius:
              BorderRadius.all(Radius.circular(15))),
          filled: true,
          fillColor: Colors.white,
          hintText: '  $title',
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              )),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 5.0),
        ),
        maxLines: 1,
        style: const TextStyle(fontSize: 14.0),
      ),
    ],
  );
}