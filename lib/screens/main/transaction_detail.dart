import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/widgets/anggota/info_anggota.dart';
import 'package:progmob_magical_destroyers/widgets/app_bar_with_back_button.dart';
import 'package:ticket_widget/ticket_widget.dart';

class TransactionDetail extends StatelessWidget {
  const TransactionDetail({super.key});

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
              height: 550,
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
          children: [
            Text("Transaction Type", style: TextStyle(fontSize: 24)),
            Container(
              width: 40,
              height: 40,
              child: Center(
                child: Image.asset("assets/bunga.png"),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Center(
          child: Text(
            "+Rp50.000",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
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
        _verticalRow("Transaction ID", "111"),
        _verticalRow("Recipient", "Aditya Mahendra"),
        _verticalRow("Datetime", "17 Apr 2024"),
        _verticalRow("Transaction ID", "111"),
        _verticalRow("Person In Charge", "Sigma Skibidi"),
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
