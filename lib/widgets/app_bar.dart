import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      elevation: 1,
      title: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: Image.asset("assets/images/logo2.jpg"),
            ),
            const Text(
              'OASIS Uz',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}
