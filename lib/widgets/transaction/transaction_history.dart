import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/screens/main/transaction_detail.dart';
import 'package:progmob_magical_destroyers/widgets/section_header.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({super.key});

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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text("APR 2024",
                style: TextStyle(
                    fontSize: 18, color: Colors.black.withOpacity(0.6))),
          ),
          ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Material(
                child: InkWell(
                  onTap: () => Get.to(() => TransactionDetail()),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: ColorPlanet.primary,
                      child: Icon(Icons.account_balance_wallet),
                    ),
                    title: Text("Transaction ${index + 1}"),
                    subtitle: Text("17 Apr 2024"),
                    trailing: Text("+Rp50.000", style: TextStyle(fontSize: 18)),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
