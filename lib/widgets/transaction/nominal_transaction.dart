import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/types/transaction_type.dart';
import 'package:progmob_magical_destroyers/widgets/full_width_button.dart';
import 'package:progmob_magical_destroyers/widgets/input/nominal_input.dart';

class NominalTransaction extends StatelessWidget {
  final TransactionType transactionType;
  final int saldo;

  NominalTransaction({
    super.key,
    required this.transactionType,
    required this.saldo,
  });

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.account_balance_wallet_sharp,
                  color: ColorPlanet.primary,
                ),
                SizedBox(width: 10),
                Text(
                  "Nominal",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 40),
            NominalInput(transactionType: transactionType, saldo: saldo),
            SizedBox(height: 40),
            _transactionType(),
            SizedBox(height: 20),
            FullWidthButton(
              type: FullWidthButtonType.primary,
              text: "Submit",
              onPressed: () {},
            ),
            isKeyboardVisible
                ? SizedBox(height: MediaQuery.of(context).viewInsets.bottom)
                : SizedBox(),
          ],
        );
      },
    );
  }

  Widget _transactionType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Type",
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey.shade500,
          ),
        ),
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              child: Center(
                child: Image.asset(transactionType.imageUrl),
              ),
            ),
            SizedBox(width: 8),
            Text(
              transactionType.name,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }
}
