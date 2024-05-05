import 'package:color_log/color_log.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:progmob_magical_destroyers/screens/get_started_screen.dart';
import 'package:progmob_magical_destroyers/screens/introduction_screen.dart';
import 'package:progmob_magical_destroyers/screens/main/main_screen.dart';

class InitialScreen {
  final String route;
  final Widget screen;

  InitialScreen({required this.route, required this.screen});
}

class AppController {
  static InitialScreen getInitialScreen() {
    final GetStorage _box = GetStorage();

    final bool? isFirstTime = _box.read('isFirstTime');
    clog.info('isFirstTime: $isFirstTime');
    if (isFirstTime != false) {
      return InitialScreen(
        route: '/introduction',
        screen: Introduction(),
      );
    }

    final String? token = _box.read('token');
    clog.info('token: $token');
    if (token == null) {
      return InitialScreen(
        route: '/get-started',
        screen: GetStarted(),
      );
    }

    return InitialScreen(
      route: '/main',
      screen: Main(),
    );
  }
}
