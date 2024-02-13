import 'package:flutter/material.dart';
import 'package:oasis_uz_mobile/constants/app_color.dart';

class FilterOptionWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function() onTap;

  const FilterOptionWidget({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.sizeOf(context).width * 0.29,
        decoration: BoxDecoration(
          color: isSelected ? mainColor : Colors.grey,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
