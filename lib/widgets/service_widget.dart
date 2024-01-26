import 'package:flutter/material.dart';
import 'package:oasis_uz_mobile/constants/app_color.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';

class ServicesWidget extends StatelessWidget {
  final String name;
  final Icon icon;

  const ServicesWidget({super.key, required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: mainColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            CustomText(
              text: name,
              weight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
