import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progmob_magical_destroyers/configs/themes/theme.dart';
import 'package:progmob_magical_destroyers/controller/profile_controller.dart';
import 'package:progmob_magical_destroyers/screens/account/edit_profile.dart';
import 'package:progmob_magical_destroyers/screens/get_started_screen.dart';
import 'package:progmob_magical_destroyers/screens/introduction_screen.dart';
import 'package:progmob_magical_destroyers/screens/main/main_screen.dart';
import 'package:progmob_magical_destroyers/screens/sign_in_screen.dart';
import 'package:progmob_magical_destroyers/widgets/loading.dart';

void main() async {
  await GetStorage.init();
  EasyLoading.instance
    ..indicatorWidget = Loading()
    ..loadingStyle = EasyLoadingStyle.light
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = false;
  Get.put(ProfileController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: ThemeMode.light,
      home: GetStarted(),
      builder: EasyLoading.init(),
    );
  }
}
