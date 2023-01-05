import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black38),
      ),
      labelText: labelText,
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, color: Colors.black)
          : const Icon(Icons.info_outline_sharp, color: Colors.black38),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black38,
          width: 2,
        ),
      ),
      hintText: hintText,
      labelStyle: const TextStyle(
        color: Colors.grey,
      ),
    );
  }
}
