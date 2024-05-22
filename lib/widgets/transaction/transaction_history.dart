import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/list_tabungan_anggota_type.dart';
import 'package:progmob_magical_destroyers/providers/transaction_provider.dart';
import 'package:progmob_magical_destroyers/screens/main/transaction_detail.dart';
import 'package:progmob_magical_destroyers/types/transaction_type.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';
import 'package:progmob_magical_destroyers/widgets/data/empty_data.dart';
import 'package:progmob_magical_destroyers/widgets/section_header.dart';
import 'package:progmob_magical_destroyers/widgets/transaction/transaction_type_list.dart';
import 'package:provider/provider.dart';

class TransactionHistory extends StatelessWidget {
  TransactionHistory({super.key});

  Text _getTextNominal(int nominal, TransactionType txnType) {
    Color color = txnType.trxMultiply == 1 ? Colors.green : Colors.red;
    String prefix = txnType.trxMultiply == 1 ? "+" : "-";
    String formattedNominal = HelplessUtil.formatNumber(nominal);

    return Text("${prefix}Rp${formattedNominal}",
        style:
            TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.bold));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          SectionHeader(title: "Transaction History", showButton: false),
          SizedBox(height: 5),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //   child: Text(
          //     "APR 2024",
          //     style: TextStyle(
          //       fontSize: 18,
          //       color: Colors.black.withOpacity(0.6),
          //     ),
          //   ),
          // ),
          Consumer<TransactionProvider>(
            builder: (context, dataProvider, child) {
              if (dataProvider.isLoading) {
                // dataProvider.getListTabunganAnggota(anggota);
                return CircularProgressIndicator();
              } else if (dataProvider.transactionList.isEmpty) {
                return EmptyData();
              }
              return ListView.builder(
                itemCount: dataProvider.transactionList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  Tabungan txn = dataProvider.transactionList[index];
                  TransactionType txnType = transactionTypes
                      .firstWhere((element) => element.id == txn.trxId);

                  return Material(
                    child: InkWell(
                      onTap: () => Get.to(() => TransactionDetail()),
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
                          HelplessUtil.formatDateTimeString(
                              txn.trxTanggal!, false),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        trailing: _getTextNominal(txn.trxNominal!, txnType),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          // ListView.builder(
          //   itemCount: 5,
          //   shrinkWrap: true,
          //   physics: NeverScrollableScrollPhysics(),
          //   itemBuilder: (context, index) {
          //     return Material(
          //       child: InkWell(
          //         onTap: () => Get.to(() => TransactionDetail()),
          //         child: ListTile(
          //           leading: CircleAvatar(
          //             backgroundColor: ColorPlanet.primary,
          //             child: Icon(Icons.account_balance_wallet),
          //           ),
          //           title: Text("Transaction ${index + 1}"),
          //           subtitle: Text("17 Apr 2024"),
          //           trailing: Text("+Rp50.000", style: TextStyle(fontSize: 18)),
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
