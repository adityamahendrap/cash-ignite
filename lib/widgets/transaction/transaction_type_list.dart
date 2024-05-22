import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progmob_magical_destroyers/widgets/transaction/nominal_transaction.dart';
import 'package:progmob_magical_destroyers/types/transaction_type.dart';
import 'package:progmob_magical_destroyers/widgets/wrapper/bottom_sheet_fit_content_wrapper.dart';

class TransactionTypeList extends StatelessWidget {
  TransactionTypeList({super.key});

  final List<TransactionType> transactionTypes = [
    TransactionType(
      id: 1,
      name: "Saldo Awal",
      icon: Icons.account_balance,
      trxMultiply: 1,
    ),
    TransactionType(
      id: 2,
      name: "Simpanan",
      icon: Icons.account_balance_wallet,
      trxMultiply: 1,
    ),
    TransactionType(
      id: 3,
      name: "Penarikan",
      icon: Icons.account_balance_wallet,
      trxMultiply: -1,
    ),
    TransactionType(
      id: 4,
      name: "Bunga Simpanan",
      icon: Icons.account_balance_wallet,
      trxMultiply: 1,
    ),
    TransactionType(
      id: 5,
      name: "Koreksi Penambahan",
      icon: Icons.account_balance_wallet,
      trxMultiply: 1,
    ),
    TransactionType(
      id: 6,
      name: "Koreksi Pengurangan",
      icon: Icons.account_balance_wallet,
      trxMultiply: -1,
    ),
  ];

  void _handleSelecedtTransactionType(
    BuildContext context,
    TransactionType transactionType,
  ) {
    Get.back();
    bottomSheetFitContentWrapper(
      context: context,
      content: NominalTransaction(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Choose Type",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(color: Colors.grey.shade300),
        ),
        ...transactionTypes
            .map((e) => ListTile(
                  leading: Icon(e.icon),
                  title: Text(e.name),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  onTap: () => _handleSelecedtTransactionType(context, e),
                ))
            .toList()
      ],
    );
  }
}
