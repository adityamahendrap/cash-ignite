import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/list_tabungan_anggota_type.dart';
import 'package:progmob_magical_destroyers/types/transaction_type.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';
import 'package:get/get.dart';
import 'package:progmob_magical_destroyers/screens/main/transaction/transaction_detail_screen.dart';

class TransactionHistoryListTile extends StatelessWidget {
  final Tabungan txn;
  final TransactionType txnType;
  final Anggota anggota;

  const TransactionHistoryListTile({
    super.key,
    required this.txn,
    required this.txnType,
    required this.anggota,
  });

  Text _getTextNominal(int nominal, TransactionType txnType) {
    Color color = txnType.trxMultiply == 1 ? ColorPlanet.primary : Colors.red;
    String prefix = txnType.trxMultiply == 1 ? "+" : "-";
    String formattedNominal = HelplessUtil.formatNumber(nominal);

    return Text("${prefix}Rp.${formattedNominal}",
        style:
            TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.bold));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => Get.to(
          () => TransactionDetailScreen(
            item: txn,
            type: txnType,
            anggota: anggota,
          ),
        ),
        child: ListTile(
          leading: Container(
            width: 30,
            height: 30,
            child: Center(
              child: Image.asset(txnType.imageUrl),
            ),
          ),
          title: Text(txnType.name),
          subtitle: Text(
            HelplessUtil.formatDateTimeString(txn.trxTanggal!, false),
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
          trailing: _getTextNominal(txn.trxNominal!, txnType),
        ),
      ),
    );
  }
}
