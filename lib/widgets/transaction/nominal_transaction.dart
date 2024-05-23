import 'package:color_log/color_log.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/mobile_api.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';
import 'package:progmob_magical_destroyers/providers/transaction_provider.dart';
import 'package:progmob_magical_destroyers/types/transaction_type.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';
import 'package:progmob_magical_destroyers/widgets/app_snack_bar.dart';
import 'package:progmob_magical_destroyers/widgets/confirmation_dialog_content.dart';
import 'package:progmob_magical_destroyers/widgets/full_width_button.dart';
import 'package:progmob_magical_destroyers/widgets/input/nominal_input.dart';
import 'package:progmob_magical_destroyers/widgets/wrapper/dialog_wrapper.dart';
import 'package:provider/provider.dart';

class NominalTransaction extends StatefulWidget {
  final TransactionType transactionType;
  final int saldo;
  final Anggota anggota;

  NominalTransaction({
    super.key,
    required this.transactionType,
    required this.saldo,
    required this.anggota,
  });

  @override
  State<NominalTransaction> createState() => _NominalTransactionState();
}

class _NominalTransactionState extends State<NominalTransaction> {
  final TextEditingController _nominalController = TextEditingController();
  final MobileApiRequester _apiRequester = MobileApiRequester();
  late TransactionProvider transactionProvider;

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
        confirmText: "Transfer",
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

  void _doTransaction(BuildContext context, String nominalFormatedStr) async {
    FocusManager.instance.primaryFocus?.unfocus(); // Close keyboard

    final int nominal = int.parse(nominalFormatedStr.replaceAll(".", ""));

    final bool isConfirmed =
        await _showConfirmationDialog(context, nominal, widget.transactionType);
    if (!isConfirmed) return;

    try {
      EasyLoading.show();
      await _apiRequester.insertTransaksiTabunganByAnggotaId(
        anggotaId: widget.anggota.id.toString(),
        trxId: widget.transactionType.id,
        trxNominal: nominal,
      );

      await Future.wait([
        transactionProvider.getSaldo(widget.anggota),
        transactionProvider.getListTabunganAnggota(widget.anggota),
      ]);

      AppSnackBar.success("Success", "Transaction success!");
    } on DioException catch (e) {
      HelplessUtil.handleApiError(e);
    } finally {
      EasyLoading.dismiss();
    }
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
          ),
          TextSpan(
            text: "${type.name} ",
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: "as much ",
          ),
          TextSpan(
            text:
                "${type.trxMultiply == 1 ? "+" : "-"}Rp${HelplessUtil.formatNumber(nominal)} ",
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: "on this anggota?",
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Save the reference to the provider here
    transactionProvider = context.read<TransactionProvider>();
  }

  @override
  dispose() {
    _nominalController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<TransactionProvider>().isNominalValid = false;
    });
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
                onPressed: () =>
                    _doTransaction(context, _nominalController.text),
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
