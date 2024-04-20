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
  final Widget? leadingButton;
  final Widget? trailingButton;
  final bool isMaxLength;
  final bool isNumber;
  final VoidCallback? onTrailingButtonPressed;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.isNumber = false,
    this.maxLines = 1,
    this.fontSize = 14,
    this.validator,
    this.initialValue,
    this.focusNode,
    this.obscureText = false,
    this.isPhone = false,
    this.leadingButton,
    this.trailingButton,
    this.isMaxLength = false,
    this.onTrailingButtonPressed,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: isMaxLength ? 1000 : null,
      controller: controller,
      focusNode: focusNode,
      maxLines: maxLines,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: TextStyle(fontSize: fontSize, color: Colors.black),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        prefixIcon: leadingButton != null
            ? IconButton(
                icon: leadingButton!,
                color: focusNode?.hasFocus ?? false ? tealColor : Colors.grey,
                onPressed: () {},
              )
            : null,
        suffixIcon: trailingButton != null
            ? IconButton(
                icon: trailingButton!,
                color: focusNode?.hasFocus ?? false ? tealColor : Colors.grey,
                onPressed: onTrailingButtonPressed,
              )
            : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: tealColor),
        ),
      ),
      validator: validator,
      initialValue: initialValue,
      textInputAction: TextInputAction.newline,
      keyboardType: isPhone
          ? TextInputType.phone
          : isNumber
              ? TextInputType.number
              : null,
    );
  }
}
