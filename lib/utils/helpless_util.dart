import 'dart:convert';
import 'dart:developer';

import 'package:color_log/color_log.dart';
import 'package:dio/dio.dart';
import 'package:progmob_magical_destroyers/controller/auth_controller.dart';
import 'package:progmob_magical_destroyers/widgets/app_snack_bar.dart';

class HelplessUtil {
  static void handleApiError(DioException e) {
    clog.error(e.toString());
    clog.error(e.response?.data.toString() ?? "No response data");
    inspect(e.response);

    if (e.response!.statusCode == 406) {
      AuthController().signOut();
      AppSnackBar.error("Session Expired",
          "Your session has been expired, please login again. Sorry for the inconvenience.");
      return;
    }

    AppSnackBar.error("Error", e.response?.data?['message'] ?? "Unknown error");
  }

  static void printPrettyJson(Map<String, dynamic> json) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String prettyprint = encoder.convert(json);
    print(prettyprint);
  }

  static int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}
