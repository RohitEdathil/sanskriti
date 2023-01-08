import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final bool isPassword;
  final TextEditingController controller;
  const CustomInput(
      {Key? key, this.isPassword = false, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hintText: isPassword ? "Password" : "Email",
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
            fillColor: const Color.fromARGB(255, 7, 25, 67),
            filled: true),
      ),
    );
  }
}
