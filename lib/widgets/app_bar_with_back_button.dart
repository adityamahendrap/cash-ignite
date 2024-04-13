import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarWithBackButton extends StatelessWidget
    implements PreferredSizeWidget {
  late final String? title;
  bool? centerTitle = true;

  AppBarWithBackButton({
    super.key,
    this.title,
    this.centerTitle,
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
      centerTitle: this.centerTitle,
      title: Text(
        this.title!,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
