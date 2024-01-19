import 'package:flutter/material.dart';

BottomNavigationBarItem customBottomNavItem(IconData icon, String label) {
  return BottomNavigationBarItem(
    icon: Icon(
      icon,
      color: Colors.black,
    ),
    label: label,
  );
}
