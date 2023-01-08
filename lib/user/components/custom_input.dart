import 'package:flutter/material.dart';

class RequestInput extends StatelessWidget {
  final bool isRemark;
  final TextEditingController controller;
  const RequestInput(
      {Key? key, this.isRemark = false, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        maxLines: isRemark ? 5 : 1,
        decoration: InputDecoration(
            hintText: isRemark ? "Remark" : "Location",
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
