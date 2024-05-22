import 'package:color_log/color_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/types/transaction_type.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';
import 'package:progmob_magical_destroyers/utils/number_input_formatter.dart';

class NominalInput extends StatelessWidget {
  final TextEditingController? controller;
  final TransactionType transactionType;
  final int saldo;

  NominalInput({
    super.key,
    this.controller,
    required this.transactionType,
    required this.saldo,
  });

  final double borderRadius = 15.0;

  String? nominalValidator(String? value) {
    if (transactionType.trxMultiply == -1) {
      if (value == null || value.isEmpty) {
        clog.info("Nominal tidak boleh kosong");
        return "Nominal tidak boleh kosong";
      }
      if (int.parse(value) > saldo) {
        clog.info("Saldo tidak mencukupi");
        return "Saldo tidak mencukupi";
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: nominalValidator,
      autofocus: true,
      controller: controller,
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
        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        hintText: "0",
        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            "${transactionType.trxMultiply == 1 ? "+" : "-"}Rp",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.black,
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
