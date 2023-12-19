import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextField getTextField(String label, String hintText, bool obscure,
    TextEditingController controller,
    {bool isNumeric = false}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      hintText: hintText,
    ),
    keyboardType: TextInputType.emailAddress, // for email
    // or
    // keyboardType: TextInputType.text, // for username
    obscureText: obscure, // for login
    inputFormatters: isNumeric
        ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
        : null,
  );
}
