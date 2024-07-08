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
import 'package:progmob_magical_destroyers/controllers/transaction_provider.dart';
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
  final Function refreshListSettingBungaCallback;

  AddSettingBunga({super.key, required this.refreshListSettingBungaCallback});

  @override
  State<AddSettingBunga> createState() => _AddSettingBungaState();
}

class _AddSettingBungaState extends State<AddSettingBunga> {
  final TextEditingController _settingBungaController = TextEditingController();
  final MobileApiRequester _apiRequester = MobileApiRequester();

  bool _isActive = true;
  bool _isDisabledButton = true;

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    late bool isConfirmed;

    await dialogWrapper(
      context: context,
      columnMainAxisAlignment: MainAxisAlignment.start,
      content: ConfirmationDialogContent(
        text: "Are you sure to add this interest rate?",
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

  Future<void> _addSettingBunga(
    BuildContext context,
    double percent,
    bool isActive,
  ) async {
    FocusManager.instance.primaryFocus?.unfocus(); // Close keyboard

    final bool isConfirmed = await _showConfirmationDialog(context);
    if (!isConfirmed) return;

    try {
      EasyLoading.show();
      await _apiRequester.addSettingBunga(percent: percent, isActive: isActive);

      AppSnackBar.success("Success", "Add interest success!");

      // refresh list setting bunga here
      await widget.refreshListSettingBungaCallback();
    } on DioException catch (e) {
      HelplessUtil.handleApiError(e);
    } finally {
      EasyLoading.dismiss();
    }
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
              setIsDisableButtonState: (bool isDisabled) {
                setState(() {
                  _isDisabledButton = isDisabled;
                });
              },
            ),
            SizedBox(height: 30),
            _activeToggle(),
            SizedBox(height: 10),
            FullWidthButton(
              type: FullWidthButtonType.primary,
              text: "Submit",
              onPressed: () => _addSettingBunga(
                context,
                double.parse(
                    _settingBungaController.text.replaceFirst(',', '.')),
                _isActive,
              ),
              isDisabled: _isDisabledButton,
            ),
            isKeyboardVisible
                ? SizedBox(height: MediaQuery.of(context).viewInsets.bottom)
                : SizedBox(),
          ],
        );
      },
    );
  }

  Widget _activeToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Active",
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey.shade500,
          ),
        ),
        Switch(
          value: _isActive,
          activeColor: ColorPlanet.primary,
          onChanged: (bool value) {
            setState(() {
              _isActive = value;
            });
          },
        ),
      ],
    );
  }
}
