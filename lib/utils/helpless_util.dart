import 'dart:convert';
import 'dart:developer';

import 'package:color_log/color_log.dart';
import 'package:dio/dio.dart';
import 'package:progmob_magical_destroyers/widgets/app_snack_bar.dart';

class HelplessUtil {
  static void handleApiError(DioException e) {
    clog.error(e.toString());
    clog.error(e.response?.data.toString() ?? "No response data");
    inspect(e);
    AppSnackBar.error("Error", e.response?.data?['message'] ?? "Unknown error");
  }

  static void printPrettyJson(Map<String, dynamic> json) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String prettyprint = encoder.convert(json);
    print(prettyprint);
  }
}
