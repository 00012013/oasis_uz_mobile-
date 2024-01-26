import 'package:flutter/material.dart';
import 'package:oasis_uz_mobile/constants/app_color.dart';

BottomNavigationBarItem customBottomNavItem(IconData icon, String label) {
  return BottomNavigationBarItem(
    activeIcon: Icon(
      icon,
      color: mainColor,
      size: 27,
      weight: 1000.0,
    ),
    label: label,
    icon: Icon(
      icon,
      color: Colors.black,
    ),
  );
}
