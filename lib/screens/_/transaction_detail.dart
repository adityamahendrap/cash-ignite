import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/list_tabungan_anggota_type.dart';
import 'package:progmob_magical_destroyers/types/transaction_type.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';
import 'package:progmob_magical_destroyers/widgets/app_bar_with_back_button.dart';
import 'package:progmob_magical_destroyers/widgets/transaction/transaction_history.dart';
import 'package:ticket_widget/ticket_widget.dart';

class TransactionDetail extends StatelessWidget {
  final Tabungan item;
  final TransactionType type;
  final Anggota anggota;

  TransactionDetail(
      {super.key,
      required this.item,
      required this.type,
      required this.anggota});

  final String _personInCharge = GetStorage().read('user')['name'];

  Text _getTextNominal(int nominal, TransactionType txnType) {
    Color color = txnType.trxMultiply == 1 ? Colors.green : Colors.black;
    String prefix = txnType.trxMultiply == 1 ? "+" : "-";
    String formattedNominal = HelplessUtil.formatNumber(nominal);

    return Text(
      "${prefix}Rp${formattedNominal}",
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPlanet.primary,
      appBar: AppBarWithBackButton(
        title: "Transaction Detail",
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 30, left: 20, right: 20),
            child: TicketWidget(
              width: MediaQuery.of(context).size.width,
              height: 520,
              isCornerRounded: true,
              padding: EdgeInsets.all(40),
              child: _transactionData(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _transactionData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Text(type.name, style: TextStyle(fontSize: 24))),
            Container(
              width: 40,
              height: 40,
              child: Center(
                child: Image.asset(type.imageUrl),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Center(
          child: _getTextNominal(item.trxNominal!, type),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 20,
            ),
            SizedBox(width: 5),
            Text("Transaction success", style: TextStyle(fontSize: 14)),
          ],
        ),
        SizedBox(height: 20),
        _verticalRow("Transaction ID", item.id.toString()),
        _verticalRow("Recipient", anggota.nama),
        _verticalRow(
          "Datetime",
          HelplessUtil.formatDateTimeString(item.trxTanggal.toString(), true),
        ),
        _verticalRow("Person In Charge", _personInCharge),
      ],
    );
  }

  Widget _verticalRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            key,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade500,
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
