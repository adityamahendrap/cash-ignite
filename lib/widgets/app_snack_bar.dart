import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';

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
      backgroundGradient: LinearGradient(
        colors: [Colors.blue, Colors.lightBlue],
      ),
    );
  }
}
