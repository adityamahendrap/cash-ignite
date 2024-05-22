import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/providers/profile_provider.dart';
import 'package:progmob_magical_destroyers/widgets/anggota/info_anggota.dart';
import 'package:progmob_magical_destroyers/widgets/app_bar_with_back_button.dart';
import 'package:get/get.dart';
import 'package:progmob_magical_destroyers/widgets/transaction/transaction_history.dart';
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
  final int saldo = 50000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackButton(
        title: "SL Pocket",
        backgroundColor: ColorPlanet.secondary,
      ),
      body: Container(
        color: ColorPlanet.secondary,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              _profilePicture(),
              SizedBox(height: 20),
              _profile(),
              SizedBox(height: 30),
              _createTransactionButton(),
              SizedBox(height: 25),
              Container(
                padding: EdgeInsets.only(top: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [ColorPlanet.secondary, Colors.white],
                  ),
                ),
              ),
              TransactionHistory()
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Full Name", style: TextStyle(fontSize: 18)),
            SizedBox(width: 5),
            InkWell(
              onTap: () => bottomSheetFitContentWrapper(
                context: context,
                content: InfoAnggota(),
                isHorizontalPaddingActive: false,
              ),
              child: Icon(Icons.info_outline, color: ColorPlanet.primary),
            ),
          ],
        ),
        TextTitle(title: "Rp50.000"),
      ],
    );
  }

  Widget _createTransactionButton() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorPlanet.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: () {
              bottomSheetFitContentWrapper(
                context: context,
                content: TransactionTypeList(saldo: saldo),
                isHorizontalPaddingActive: false,
              );
            },
          ),
        ),
        SizedBox(height: 5),
        Text("Add Transaction", style: TextStyle(fontSize: 14)),
      ],
    );
  }

  Text _tabText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16),
    );
  }
}


// DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBarWithBackButton(
//           title: "SL Pocket",
//           backgroundColor: ColorPlanet.secondary,
//         ),
//         body: Container(
//           // color: ColorPlanet.secondary,
//           color: Colors.white,
//           child: SingleChildScrollView(
//             child: ConstrainedBox(
//               constraints:
//                   BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(height: 50),
//                   _profilePicture(),
//                   SizedBox(height: 20),
//                   _profile(),
//                   SizedBox(height: 20),
//                   _createTransactionButton(),
//                   Container(
//                     padding: EdgeInsets.only(top: 50),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       // gradient: LinearGradient(
//                       //   begin: Alignment.topCenter,
//                       //   end: Alignment.bottomCenter,
//                       //   colors: [ColorPlanet.secondary, Colors.white],
//                       // ),
//                     ),
//                     child: TabBar(
//                       tabs: [
//                         Tab(child: _tabText('History')),
//                         Tab(child: _tabText('Info')),
//                       ],
//                       labelColor: Colors.black,
//                       unselectedLabelColor: Colors.grey,
//                     ),
//                   ),
//                   // fit height based on content
//                   Expanded(
//                     child: TabBarView(
//                       children: [
//                         SingleChildScrollView(child: TransactionHistory()),
//                         SingleChildScrollView(child: InfoAnggota()),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );