import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/list_tabungan_anggota_type.dart';
import 'package:progmob_magical_destroyers/providers/transaction_provider.dart';
import 'package:progmob_magical_destroyers/widgets/transaction/nominal_transaction.dart';
import 'package:progmob_magical_destroyers/types/transaction_type.dart';
import 'package:progmob_magical_destroyers/widgets/wrapper/bottom_sheet_fit_content_wrapper.dart';
import 'package:provider/provider.dart';

class TransactionTypeList extends StatefulWidget {
  final int saldo;

  TransactionTypeList({super.key, required this.saldo});

  @override
  State<TransactionTypeList> createState() => _TransactionTypeListState();
}

class _TransactionTypeListState extends State<TransactionTypeList> {
  List<TransactionType> _filteredTransactionTypes = [];

  void _getFilteredTransactionTypes(BuildContext context) {
    List<Tabungan> transactionList =
        context.read<TransactionProvider>().transactionList;

    List<TransactionType> temp;

    if (transactionList.isEmpty) {
      temp = transactionTypes
          .where((element) => [1, 2].contains(element.id))
          .toList();
    } else {
      temp = transactionTypes
          .where((element) => ![1].contains(element.id))
          .toList();
    }

    setState(() {
      _filteredTransactionTypes = temp;
    });
  }

  void _handleSelecedtTransactionType(
    BuildContext context,
    TransactionType transactionType,
  ) {
    Get.back();
    bottomSheetFitContentWrapper(
      context: context,
      content: NominalTransaction(
          transactionType: transactionType, saldo: widget.saldo),
    );
  }

  @override
  void initState() {
    _getFilteredTransactionTypes(context);
    super.initState();
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
        ..._filteredTransactionTypes
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
