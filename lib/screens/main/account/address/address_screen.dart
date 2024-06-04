import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progmob_magical_destroyers/screens/main/account/address/add_new_address_screen.dart';
import 'package:progmob_magical_destroyers/widgets/address_card.dart';
import 'package:progmob_magical_destroyers/widgets/app_bar_with_back_button.dart';
import 'package:progmob_magical_destroyers/widgets/full_width_button_bottom_bar.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackButton(
        title: 'Address',
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return AddressCard(index: index, onTap: () {});
              },
            ),
          ),
          FullWidthButtonBottomBar(
            context: context,
            text: 'Add New Adress',
            onPressed: () {
              // Get.to(() => AddNewAddressScreen());
            },
          )
        ],
      ),
    );
  }
}
