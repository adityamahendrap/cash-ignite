import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/widgets/transaction/nominal_transaction.dart';
import 'package:progmob_magical_destroyers/types/transaction_type.dart';
import 'package:progmob_magical_destroyers/widgets/wrapper/bottom_sheet_fit_content_wrapper.dart';

class TransactionTypeList extends StatelessWidget {
  final int saldo;

  TransactionTypeList({super.key, required this.saldo});

  final List<TransactionType> transactionTypes = [
    TransactionType(
      id: 1,
      name: "Saldo Awal",
      imageUrl: "assets/initial.png",
      trxMultiply: 1,
    ),
    TransactionType(
      id: 2,
      name: "Simpanan",
      imageUrl: "assets/simpanan.png",
      trxMultiply: 1,
    ),
    TransactionType(
      id: 3,
      name: "Penarikan",
      imageUrl: "assets/penarikan.png",
      trxMultiply: -1,
    ),
    // TransactionType(
    //   id: 4,
    //   name: "Bunga Simpanan",
    //   imageUrl: "assets/bunga.png",
    //   trxMultiply: 1,
    // ),
    TransactionType(
      id: 5,
      name: "Koreksi Penambahan",
      imageUrl: "assets/koreksi.png",
      trxMultiply: 1,
    ),
    TransactionType(
      id: 6,
      name: "Koreksi Pengurangan",
      imageUrl: "assets/koreksi.png",
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
      content:
          NominalTransaction(transactionType: transactionType, saldo: saldo),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          margin: EdgeInsets.only(bottom: 25),
          child: Row(
            children: [
              Icon(
                Icons.backup,
                color: ColorPlanet.primary,
              ),
              SizedBox(width: 10),
              Text(
                "Choose Transaction Type",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
        ),
        // Text(
        //   "Choose Type",
        //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        // ),
        // SizedBox(height: 5),
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 20),
        //   child: Divider(color: Colors.grey.shade300),
        // ),
        ...transactionTypes
            .map((e) => ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    child: Center(
                      child: Image.asset(e.imageUrl),
                    ),
                  ),
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
