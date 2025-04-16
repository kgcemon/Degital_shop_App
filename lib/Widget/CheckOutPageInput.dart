import 'package:flutter/material.dart';

class CheckoutInput {
  static Widget checkoutInput(
      TextInputType inputType, TextEditingController controller, String name,Icon icon) {
    return TextField(
      keyboardType: inputType,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: icon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xff0D6EFC)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xff0D6EFC)),
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
