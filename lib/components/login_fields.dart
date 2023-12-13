import 'package:flutter/material.dart';

class LoginFields extends StatelessWidget {
  final dynamic controller;
  final String hintText;
  final bool obscureText;

  const LoginFields({
    super.key,
    this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0),
      child: TextField(
        style: const TextStyle(
          color: Colors.white,
        ),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
