import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/providers/profile_provider.dart';
import 'package:progmob_magical_destroyers/widgets/app_bar_with_back_button.dart';
import 'package:get/get.dart';
import 'package:progmob_magical_destroyers/widgets/transaction/transaction_type_list.dart';
import 'package:progmob_magical_destroyers/widgets/photo_view.dart';
import 'package:progmob_magical_destroyers/widgets/section_header.dart';
import 'package:progmob_magical_destroyers/widgets/text_title.dart';
import 'package:progmob_magical_destroyers/widgets/wrapper/bottom_sheet_fit_content_wrapper.dart';

class DetailAnggotaScreen extends StatefulWidget {
  const DetailAnggotaScreen({super.key});

  @override
  State<DetailAnggotaScreen> createState() => _DetailAnggotaScreenState();
}

class _DetailAnggotaScreenState extends State<DetailAnggotaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackButton(
        title: "SL Pocket",
        backgroundColor: ColorPlanet.secondary,
      ),
      body: Container(
        color: ColorPlanet.secondary,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              _profilePicture(),
              SizedBox(height: 20),
              _profile(),
              SizedBox(height: 20),
              _createTransactionButton(),
              SizedBox(height: 60),
              _tranactionList()
            ],
          ),
        ),
      ),
    );
  }

  Widget _profilePicture() {
    return Center(
      child: GestureDetector(
        onTap: () {
          Get.to(() => PhotoView(image: AssetImage(defaultImagePath)));
        },
        child: CircleAvatar(
          radius: 50,
          backgroundColor: ColorPlanet.primary,
          backgroundImage: AssetImage(defaultImagePath),
        ),
      ),
    );
  }

  Widget _profile() {
    return Column(
      children: [
        Text("Full Name", style: TextStyle(fontSize: 18)),
        TextTitle(title: "Rp50.000"),
      ],
    );
  }

  ElevatedButton _createTransactionButton() {
    return ElevatedButton(
      onPressed: () => bottomSheetFitContentWrapper(
        context: context,
        content: TransactionTypeList(),
        isHorizontalPaddingActive: false,
      ),
      child: Text(
        "Create Transaction",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        backgroundColor: ColorPlanet.primary,
        elevation: 0,
      ),
    );
  }

  Widget _tranactionList() {
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
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: ColorPlanet.primary,
                  child: Icon(Icons.account_balance_wallet),
                ),
                title: Text("Transaction ${index + 1}"),
                subtitle: Text("17 Apr 2024"),
                trailing: Text("+Rp50.000", style: TextStyle(fontSize: 18)),
              );
            },
          ),
        ],
      ),
    );
  }
}
