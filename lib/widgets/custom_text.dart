import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double size;
  final Color color;
  final FontWeight weight;
  final int maxLines;
  final TextAlign textAlign;

  const CustomText({
    super.key,
    required this.text,
    this.size = 16.0,
    this.color = Colors.black,
    this.weight = FontWeight.normal,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLines,
      text ?? '',
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight,
      ),
      textAlign: textAlign,
    );
  }
}
