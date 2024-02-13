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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: mainColor,
            ),
            child: icon,
          ),
          const SizedBox(
            height: 8,
          ),
          CustomText(
            text: name,
            size: 14,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
