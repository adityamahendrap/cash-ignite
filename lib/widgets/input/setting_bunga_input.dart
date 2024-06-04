import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/providers/transaction_provider.dart';
import 'package:progmob_magical_destroyers/types/transaction_type.dart';
import 'package:progmob_magical_destroyers/utils/number_input_formatter.dart';
import 'package:provider/provider.dart';

class SettingBungaInput extends StatefulWidget {
  final TextEditingController controller;

  SettingBungaInput({
    super.key,
    required this.controller,
  });

  @override
  State<SettingBungaInput> createState() => _SettingBungaInputState();
}

class _SettingBungaInputState extends State<SettingBungaInput> {
  final double borderRadius = 15.0;

  String? _nominalValidator(String? value, BuildContext context) {
    int valueNum;
    bool isValid = true;
    String? errorMessage = null;

    if (value != null && value.isNotEmpty) {
      valueNum = int.parse(value.replaceAll('.', ''));
    } else {
      valueNum = 0;
    }

    // defer after build
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<TransactionProvider>().isNominalValid = isValid;
    });

    return errorMessage;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => _nominalValidator(value, context),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: true,
      controller: widget.controller,
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w900,
        color: Colors.black,
        height: 1,
      ),
      // textAlign: TextAlign.center,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        NumberInputFormatter()
      ],
      cursorColor: Colors.blue,
      cursorWidth: 5,
      cursorRadius: Radius.circular(20),
      decoration: InputDecoration(
        // fillColor: Colors.grey.shade100,
        // filled: true,
        contentPadding: EdgeInsets.all(20),
        hintText: "0",
        suffixText: " %",
        suffixStyle: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w900,
          color: Colors.black,
          height: 1,
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
