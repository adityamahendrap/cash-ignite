import 'package:color_log/color_log.dart';
import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/list_tabungan_anggota_type.dart';
import 'package:progmob_magical_destroyers/controllers/transaction_provider.dart';
import 'package:progmob_magical_destroyers/types/transaction_type.dart';
import 'package:progmob_magical_destroyers/widgets/data/empty_data.dart';
import 'package:progmob_magical_destroyers/widgets/section_header.dart';
import 'package:progmob_magical_destroyers/widgets/transaction/transaction_history_list_tile.dart';
import 'package:progmob_magical_destroyers/widgets/transaction/transaction_history_lsit_tile_skeleton.dart';
import 'package:provider/provider.dart';

class GroupedTransaction {
  final String monthYear;
  final List<Tabungan> transactions;

  GroupedTransaction({required this.monthYear, required this.transactions});
}

class TransactionHistory extends StatelessWidget {
  final Anggota anggota;

  TransactionHistory({super.key, required this.anggota});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.55),
      child: Column(
        children: [
          SizedBox(height: 20),
          SectionHeader(title: "Transaction History", showButton: false),
          SizedBox(height: 10),
          Consumer<TransactionProvider>(
            builder: (context, dataProvider, child) {
              if (dataProvider.isLoadingList) {
                clog.debug("loading transaction history list");
                // dataProvider.getListTabunganAnggota(anggota);
                return TransactionHistoryListTileSkeleton(itemCount: 6);
              } else if (dataProvider.transactionList.isEmpty) {
                clog.debug("empty transaction history list");
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 150),
                  child: Center(child: EmptyData()),
                );
              }
              return ListView.builder(
                itemCount: dataProvider.transactionList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  // reverse to show the latest transaction on top
                  Tabungan txn = dataProvider.transactionList[
                      dataProvider.transactionList.length - 1 - index];
                  TransactionType txnType = transactionTypes
                      .firstWhere((element) => element.id == txn.trxId);

                  return TransactionHistoryListTile(
                    txn: txn,
                    txnType: txnType,
                    anggota: anggota,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Map<String, List<Tabungan>> _groupByMonthYear(List<Tabungan> transactions) {
    Map<String, List<Tabungan>> groupedTransactions = {};
    for (Tabungan transaction in transactions) {
      DateTime transactionDate = DateTime.parse(transaction.trxTanggal!);
      String monthYear =
          "${formatMonth(transactionDate.month)} ${transactionDate.year}";
      if (groupedTransactions.containsKey(monthYear)) {
        groupedTransactions[monthYear]!.add(transaction);
      } else {
        groupedTransactions[monthYear] = [transaction];
      }
    }

    Map<String, dynamic> transactionsObject =
        groupedTransactions.map((key, value) => MapEntry(key, value));

    print(transactionsObject);

    return groupedTransactions;
  }

  Widget _monthYearHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        "APR 2024",
        style: TextStyle(
          fontSize: 18,
          color: Colors.black.withOpacity(0.6),
        ),
      ),
    );
  }

  String formatMonth(int month) {
    switch (month) {
      case 1:
        return "JAN";
      case 2:
        return "FEB";
      case 3:
        return "MAR";
      case 4:
        return "APR";
      case 5:
        return "MAY";
      case 6:
        return "JUN";
      case 7:
        return "JUL";
      case 8:
        return "AUG";
      case 9:
        return "SEP";
      case 10:
        return "OCT";
      case 11:
        return "NOV";
      case 12:
        return "DEC";
      default:
        return "";
    }
  }
}
