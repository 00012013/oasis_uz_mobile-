import 'package:flutter/material.dart';

class CustomSnackBar {
  final Color backgroundColor;

  CustomSnackBar({this.backgroundColor = Colors.red});

  void showError(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        animation: CurvedAnimation(
          parent: AnimationController(
            vsync: Scaffold.of(context),
            duration: const Duration(milliseconds: 250),
          ),
          curve: Curves.fastOutSlowIn,
        ),
        content: Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                maxLines: 3,
                errorMessage,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
