import 'package:flutter/material.dart';
import 'package:todo/my_theme.dart';

class CustomTextFormField extends StatelessWidget {
  String label;
  TextInputType keyBoardType;
  TextEditingController controller;
  String? Function(String?) validator;
  bool obscureText;

  CustomTextFormField(
      {required this.label,
      this.keyBoardType = TextInputType.text,
      required this.controller,
      required this.validator,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
          label: Text(label),
          labelStyle: Theme.of(context).textTheme.displayMedium,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                BorderSide(width: 3, color: Theme.of(context).primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                BorderSide(width: 3, color: Theme.of(context).primaryColor),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                BorderSide(width: 3, color: Theme.of(context).primaryColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 3, color: MyTheme.redColor),
          ),
        ),
        keyboardType: keyBoardType,
        controller: controller,
        validator: validator,
      ),
    );
  }
}
