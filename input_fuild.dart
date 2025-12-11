// input_fuild.dart

import 'package:flutter/material.dart';

class Appinputfuild extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final bool isDecimal; // দশমিক ইনপুট সাপোর্ট করার জন্য

  const Appinputfuild({
    super.key,
    required this.controller,
    this.labelText,
    this.isDecimal = true, // ডিফল্টভাবে দশমিক ইনপুট সাপোর্ট
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Colors.blue;
    const Color lightSurfaceColor = Colors.white;

    return TextField(
      controller: controller,
      // দশমিক ইনপুট সাপোর্টের জন্য সঠিক কিবোর্ড টাইপ
      keyboardType: isDecimal
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.number,

      style: const TextStyle(color: Colors.black87),
      cursorColor: primaryColor,

      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: primaryColor, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        label: Text(labelText!),
        labelStyle: const TextStyle(color: Colors.grey),
        hintText: labelText,
        hintStyle: const TextStyle(color: Colors.grey),
        fillColor: lightSurfaceColor,
        filled: true,
      ),
    );
  }
}