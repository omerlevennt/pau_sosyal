import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final Widget prefixIcon;
  final Widget suffixIcon;

  const MyTextField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller,
      required this.prefixIcon,
      required this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText.tr(),
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
