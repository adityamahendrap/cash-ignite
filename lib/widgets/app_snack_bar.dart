import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackBar {
  static SnackbarController error(String title, dynamic message) {
    return Get.snackbar(
      title,
      message.toString(),
      backgroundGradient: LinearGradient(
        colors: [Colors.red, Colors.orange],
      ),
    );
  }

  static SnackbarController success(String title, dynamic message) {
    return Get.snackbar(
      title,
      message.toString(),
      // backgroundGradient: LinearGradient(
      //   colors: [Colors.blue, Colors.lightBlue],
      // ),
      backgroundColor: Colors.white,
    );
  }
}
