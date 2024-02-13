import 'package:flutter/material.dart';
import 'package:oasis_uz_mobile/constants/app_color.dart';

BottomNavigationBarItem customBottomNavItem(IconData icon, String label) {
  return BottomNavigationBarItem(
    activeIcon: Icon(
      icon,
      color: mainColor,
      size: 27,
    ),
    label: label,
    tooltip: label,
    icon: Icon(
      icon,
      color: Colors.black,
      size: 27,
    ),
  );
}
