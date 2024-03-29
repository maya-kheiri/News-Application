import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final String hint;
  final int? maxLength;
  final TextEditingController controller;
  final bool obscureText;

  const AppTextField(
      {this.keyboardType = TextInputType.text,
      required this.hint,
      this.maxLength,
      required this.controller,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: maxLength,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: hint,
        counterText: '',
        enabledBorder: border,
        focusedBorder: border,
      ),
    );
  }

  OutlineInputBorder get border => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          width: 1,
          color: Colors.grey.shade400,
        ),
      );
}
