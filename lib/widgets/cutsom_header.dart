import 'package:flutter/material.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';

class AppHeader extends StatelessWidget {
  final String text;

  const AppHeader(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      child: Center(
        heightFactor: 2.5,
        child: CustomText(
          text: text,
          size: 20,
          weight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}
