import 'package:color_log/color_log.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/mobile_api.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';
import 'package:progmob_magical_destroyers/providers/transaction_provider.dart';
import 'package:progmob_magical_destroyers/types/transaction_type.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';
import 'package:progmob_magical_destroyers/widgets/app_snack_bar.dart';
import 'package:progmob_magical_destroyers/widgets/confirmation_dialog_content.dart';
import 'package:progmob_magical_destroyers/widgets/full_width_button.dart';
import 'package:progmob_magical_destroyers/widgets/input/setting_bunga_input.dart';
import 'package:progmob_magical_destroyers/widgets/input/nominal_input.dart';
import 'package:progmob_magical_destroyers/widgets/wrapper/dialog_wrapper.dart';
import 'package:provider/provider.dart';

class AddSettingBunga extends StatefulWidget {
  AddSettingBunga({super.key});

  @override
  State<AddSettingBunga> createState() => _AddSettingBungaState();
}

class _AddSettingBungaState extends State<AddSettingBunga> {
  final TextEditingController _settingBungaController = TextEditingController();
  final MobileApiRequester _apiRequester = MobileApiRequester();

  Future<bool> _showConfirmationDialog(
    BuildContext context,
    int nominal,
    TransactionType type,
  ) async {
    late bool isConfirmed;

    await dialogWrapper(
      context: context,
      columnMainAxisAlignment: MainAxisAlignment.start,
      content: ConfirmationDialogContent(
        textWidget: _getConfirmTextWidget(nominal, type),
        confirmText: "Yes, I'm sure",
        onConfirmed: () {
          isConfirmed = true;
          Get.back();
          Get.back();
        },
        onCanceled: () {
          isConfirmed = false;
          Get.back();
        },
      ),
    );

    return isConfirmed;
  }

  _getConfirmTextWidget(int nominal, TransactionType type) {
    Color textColor = type.trxMultiply == 1 ? ColorPlanet.primary : Colors.red;
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
        children: [
          TextSpan(
            text: "Are you sure to do ",
            style: GoogleFonts.poppins(),
          ),
          TextSpan(
            text: "${type.name} ",
            style: GoogleFonts.poppins(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: "as much ",
            style: GoogleFonts.poppins(),
          ),
          TextSpan(
            text:
                "${type.trxMultiply == 1 ? "+" : "-"}Rp${HelplessUtil.formatNumber(nominal)} ",
            style: GoogleFonts.poppins(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: "on this anggota?",
            style: GoogleFonts.poppins(),
          ),
        ],
      ),
    );
  }

  @override
  dispose() {
    _settingBungaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.percent,
                  color: ColorPlanet.primary,
                ),
                SizedBox(width: 10),
                Text(
                  "Add Interest Rate",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text("Maximum interest rate is "),
                Text(
                  "10%",
                  style: TextStyle(
                      color: ColorPlanet.primary, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            SettingBungaInput(
              controller: _settingBungaController,
            ),
            SizedBox(height: 40),
            FullWidthButton(
              type: FullWidthButtonType.primary,
              text: "Submit",
              onPressed: () {},
              isDisabled: false,
            ),
            isKeyboardVisible
                ? SizedBox(height: MediaQuery.of(context).viewInsets.bottom)
                : SizedBox(),
          ],
        );
      },
    );
  }
}
