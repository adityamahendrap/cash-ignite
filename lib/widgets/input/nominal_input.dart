import 'package:color_log/color_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/controllers/transaction_provider.dart';
import 'package:progmob_magical_destroyers/types/transaction_type.dart';
import 'package:progmob_magical_destroyers/utils/number_input_formatter.dart';
import 'package:provider/provider.dart';

class NominalInput extends StatefulWidget {
  final TransactionType transactionType;
  final int saldo;
  final TextEditingController controller;

  NominalInput({
    super.key,
    required this.transactionType,
    required this.saldo,
    required this.controller,
  });

  @override
  State<NominalInput> createState() => _NominalInputState();
}

class _NominalInputState extends State<NominalInput> {
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

    if (widget.transactionType.trxMultiply == -1 && valueNum > widget.saldo) {
      isValid = false;
      errorMessage = "Balance is not enough";
    } else if (valueNum == 0) {
      isValid = false;
    }

    clog.debug(valueNum.toString());

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
        contentPadding: EdgeInsets.symmetric(vertical: 20),
        hintText: "0",
        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            "${widget.transactionType.trxMultiply == 1 ? "+" : "-"}Rp.",
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
