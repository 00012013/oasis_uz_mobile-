import 'package:flutter/material.dart';
import 'package:oasis_uz_mobile/constants/app_color.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final double fontSize;
  final int maxLines;
  final String? Function(String?)? validator;
  final String? initialValue;
  final FocusNode? focusNode;
  final bool obscureText;
  final bool isPhone;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.maxLines = 1,
    this.fontSize = 14,
    this.validator,
    this.initialValue,
    this.focusNode,
    this.obscureText = false,
    this.isPhone = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      maxLines: maxLines,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: TextStyle(fontSize: fontSize, color: Colors.black),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: tealColor)),
      ),
      validator: validator,
      initialValue: initialValue,
      textInputAction: TextInputAction.newline,
      keyboardType: isPhone ? TextInputType.phone : null,
    );
  }
}
