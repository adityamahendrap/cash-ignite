import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/mobile_api.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/saldo_anggota_type.dart';
import 'package:progmob_magical_destroyers/providers/profile_provider.dart';
import 'package:progmob_magical_destroyers/providers/transaction_provider.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';
import 'package:progmob_magical_destroyers/widgets/anggota/anggota_information.dart';
import 'package:progmob_magical_destroyers/widgets/app_bar_with_back_button.dart';
import 'package:get/get.dart';
import 'package:progmob_magical_destroyers/widgets/transaction/transaction_history.dart';
import 'package:progmob_magical_destroyers/widgets/transaction/transaction_type_list.dart';
import 'package:progmob_magical_destroyers/widgets/photo_view.dart';
import 'package:progmob_magical_destroyers/widgets/text_title.dart';
import 'package:progmob_magical_destroyers/widgets/wrapper/bottom_sheet_fit_content_wrapper.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:provider/provider.dart';

class AnggotaDetailScreen extends StatefulWidget {
  const AnggotaDetailScreen({super.key});

  @override
  State<AnggotaDetailScreen> createState() => AnggotaDetailScreenState();
}

class AnggotaDetailScreenState extends State<AnggotaDetailScreen> {
  final Anggota anggota = Get.arguments['anggota'] as Anggota;

  @override
  void initState() {
    context.read<TransactionProvider>().getSaldo(anggota);
    context.read<TransactionProvider>().getListTabunganAnggota(anggota);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackButton(
        title: "SL Pocket",
        backgroundColor: ColorPlanet.secondary,
        onBackButtonPressed: () {
          Get.back();
          context.read<TransactionProvider>().clearTransactionList();
        },
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
              _nameAndSaldo(),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _createTransactionButton(),
                  SizedBox(width: 40),
                  _anggotaInfoButton(),
                ],
              ),
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
              TransactionHistory(anggota: anggota)
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

  Widget _nameAndSaldo() {
    return Column(
      children: [
        Text(anggota.nama, style: TextStyle(fontSize: 18)),
        Consumer<TransactionProvider>(
          builder: (context, provider, child) {
            return provider.isLoadingSaldo
                ? Skeletonizer(
                    enabled: true,
                    child: TextTitle(title: "Rp1.000.000"),
                  )
                : TextTitle(
                    title: "Rp${HelplessUtil.formatNumber(provider.saldo)}",
                  );
          },
        ),
      ],
    );
  }

  Widget _createTransactionButton() {
    return Container(
      width: 70,
      child: Column(
        children: [
          Consumer<TransactionProvider>(
            builder: (context, provider, child) {
              return Container(
                decoration: BoxDecoration(
                  color: provider.isLoadingSaldo
                      ? Colors.grey.shade400
                      : ColorPlanet.primary,
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
                  icon: Icon(
                    Icons.add,
                    color: provider.isLoadingSaldo
                        ? Colors.grey.shade100
                        : Colors.white,
                  ),
                  onPressed: provider.isLoadingSaldo
                      ? null
                      : () {
                          bottomSheetFitContentWrapper(
                            context: context,
                            content: TransactionTypeList(
                              saldo: provider.saldo,
                              anggota: anggota,
                            ),
                            isHorizontalPaddingActive: false,
                          );
                        },
                ),
              );
            },
          ),
          SizedBox(height: 5),
          Text("Create\nTxn",
              textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _anggotaInfoButton() {
    return Container(
      width: 70,
      child: Column(
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
              icon: Icon(
                Icons.info_outline_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                bottomSheetFitContentWrapper(
                  context: context,
                  content: AnggotaInformation(anggota: anggota),
                  isHorizontalPaddingActive: false,
                );
              },
            ),
          ),
          SizedBox(height: 5),
          Text("Anggota\nInfo",
              textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
        ],
      ),
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
//                   _nameAndSaldo(),
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