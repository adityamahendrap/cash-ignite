import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarWithBackButton extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarWithBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
