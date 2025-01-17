import 'dart:convert';
import 'dart:developer';

import 'package:color_log/color_log.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:progmob_magical_destroyers/controllers/auth_controller.dart';
import 'package:progmob_magical_destroyers/widgets/app_snack_bar.dart';

class HelplessUtil {
  static void handleApiError(DioException e) {
    clog.error(e.toString());
    clog.error(e.response.toString());
    clog.error(e.response?.data.toString() ?? "No response data");
    inspect(e);
    inspect(e.response);
    inspect(e.response?.data);

    clog.error('Error Status Code: ${e.response?.statusCode}');
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

  static String getTimeOfDay() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'morning';
    } else if (hour < 17) {
      return 'afternoon';
    } else if (hour < 20) {
      return 'evening';
    } else {
      return 'night';
    }
  }

  static String formatNumber(int number) {
    final formatter = NumberFormat('#,##0', 'en_US');
    return formatter.format(number).replaceAll(',', '.');
  }

  static String formatDateTimeString(String datetimeStr, bool withtime) {
    String outputFormat = withtime ? "dd MMM yyyy HH:mm:ss" : "dd MMM yyyy";

    DateTime dateTime = DateTime.parse(datetimeStr);
    return DateFormat(outputFormat).format(dateTime);
  }
}
