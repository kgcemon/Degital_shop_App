import 'package:flutter/material.dart';

class CheckoutInput {
  static Widget checkoutInput(
      TextInputType inputType, TextEditingController controller, String name) {
    return TextField(
      keyboardType: inputType,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.green),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: name,
        hintStyle: const TextStyle(fontSize: 10.0),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
