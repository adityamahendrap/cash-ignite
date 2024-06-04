import 'package:color_log/color_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/providers/transaction_provider.dart';
import 'package:progmob_magical_destroyers/types/transaction_type.dart';
import 'package:progmob_magical_destroyers/utils/decimal_input_formatter.dart';
import 'package:progmob_magical_destroyers/utils/number_input_formatter.dart';
import 'package:provider/provider.dart';

class SettingBungaInput extends StatefulWidget {
  final TextEditingController controller;
  final Function(bool) setIsDisableButtonState;

  SettingBungaInput({
    super.key,
    required this.controller,
    required this.setIsDisableButtonState,
  });

  @override
  State<SettingBungaInput> createState() => _SettingBungaInputState();
}

class _SettingBungaInputState extends State<SettingBungaInput> {
  final double borderRadius = 15.0;

  String? _validator(String? value, BuildContext context) {
    double valueNum;
    bool isValid = false;
    String? errorMessage = null;

    if (value != null && value.isNotEmpty) {
      valueNum = double.parse(value);

      if (valueNum >= 0 && valueNum <= 10) {
        isValid = true;
      } else {
        errorMessage = "Interest rate must be between 0 and 10";
      }
    }

    // defer after build
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      widget.setIsDisableButtonState(!isValid);
    });

    return errorMessage;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => _validator(value, context),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: true,
      controller: widget.controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w900,
        color: Colors.black,
        height: 1,
      ),
      // textAlign: TextAlign.center,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
        TextInputFormatter.withFunction(
          (oldValue, newValue) {
            final text = newValue.text;
            return text.isEmpty
                ? newValue
                : double.tryParse(text) == null
                    ? oldValue
                    : newValue;
          },
        ),
      ],
      cursorColor: Colors.blue,
      cursorWidth: 5,
      cursorRadius: Radius.circular(20),
      decoration: InputDecoration(
        // fillColor: Colors.grey.shade100,
        // filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        hintText: "0",
        prefixIcon: SizedBox(width: 24),
        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 24),
          child: Text(
            " %",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Colors.black,
              height: 1,
            ),
          ),
        ),
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: ColorPlanet.primary,
            width: 3.0,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: ColorPlanet.primary, width: 3.0),
        ),
      ),
    );
  }
}
