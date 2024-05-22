import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progmob_magical_destroyers/screens/_/cart_screen.dart';

class AppBarWithBackButton extends StatelessWidget
    implements PreferredSizeWidget {
  late final String? title;
  bool? centerTitle = true;
  final Color? backgroundColor;
  final Function? onBackButtonPressed;

  AppBarWithBackButton({
    super.key,
    this.title,
    this.centerTitle,
    this.backgroundColor = Colors.white,
    this.onBackButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          if (onBackButtonPressed != null) {
            onBackButtonPressed!();
          } else {
            Get.back();
          }
        },
      ),
      centerTitle: this.centerTitle,
      title: Text(
        this.title ?? '',
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
