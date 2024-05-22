import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/providers/transaction_provider.dart';
import 'package:progmob_magical_destroyers/types/transaction_type.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';
import 'package:progmob_magical_destroyers/widgets/app_snack_bar.dart';
import 'package:progmob_magical_destroyers/widgets/full_width_button.dart';
import 'package:progmob_magical_destroyers/widgets/input/nominal_input.dart';
import 'package:provider/provider.dart';

class NominalTransaction extends StatefulWidget {
  final TransactionType transactionType;
  final int saldo;

  NominalTransaction({
    super.key,
    required this.transactionType,
    required this.saldo,
  });

  @override
  State<NominalTransaction> createState() => _NominalTransactionState();
}

class _NominalTransactionState extends State<NominalTransaction> {
  final TextEditingController _nominalController = TextEditingController();

  void _submit(BuildContext context) {}

  @override
  dispose() {
    _nominalController.dispose();
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
            Row(
              children: [
                Text("Current balance is "),
                Text(
                  "Rp${HelplessUtil.formatNumber(widget.saldo)}",
                  style: TextStyle(
                      color: ColorPlanet.primary, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            NominalInput(
              transactionType: widget.transactionType,
              saldo: widget.saldo,
              controller: _nominalController,
            ),
            SizedBox(height: 40),
            _transactionType(),
            SizedBox(height: 20),
            FullWidthButton(
                type: FullWidthButtonType.primary,
                text: "Submit",
                onPressed: () => _submit(context),
                isDisabled:
                    !context.watch<TransactionProvider>().isNominalValid),
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
                child: Image.asset(widget.transactionType.imageUrl),
              ),
            ),
            SizedBox(width: 8),
            Text(
              widget.transactionType.name,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }
}
