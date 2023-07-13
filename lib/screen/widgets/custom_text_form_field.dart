import 'package:flutter/material.dart';
import '../../style/colors.dart';

class CostumTextFormField extends StatelessWidget {
  String hinttitle;
  String labeltitle;
  TextEditingController controller;

  CostumTextFormField(
      {super.key,
      required this.hinttitle,
      required this.labeltitle,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "You must enter a value";
        } else if (value.length < 6) {
          return "You must enter a value greater than 6 characters ";
        }
      },
      onTap: () {},
      decoration: InputDecoration(
        hintText: hinttitle,
        labelText: hinttitle,
        labelStyle: const TextStyle(fontSize: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
        errorStyle: TextStyle(fontSize: 15),
      ),
    );
  }
}
