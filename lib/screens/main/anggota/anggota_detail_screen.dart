import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/mobile_api.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';
import 'package:progmob_magical_destroyers/controllers/transaction_provider.dart';
import 'package:progmob_magical_destroyers/screens/main/anggota/edit_anggota_screen.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';
import 'package:progmob_magical_destroyers/widgets/anggota/anggota_information.dart';
import 'package:get/get.dart';
import 'package:progmob_magical_destroyers/widgets/app_snack_bar.dart';
import 'package:progmob_magical_destroyers/widgets/confirmation_dialog_content.dart';
import 'package:progmob_magical_destroyers/widgets/transaction/transaction_history.dart';
import 'package:progmob_magical_destroyers/widgets/transaction/transaction_type_list.dart';
import 'package:progmob_magical_destroyers/widgets/text_title.dart';
import 'package:progmob_magical_destroyers/widgets/wrapper/bottom_sheet_fit_content_wrapper.dart';
import 'package:progmob_magical_destroyers/widgets/wrapper/dialog_wrapper.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:provider/provider.dart';

class AnggotaDetailScreen extends StatefulWidget {
  final Anggota anggota;
  const AnggotaDetailScreen({super.key, required this.anggota});

  @override
  State<AnggotaDetailScreen> createState() => AnggotaDetailScreenState();
}

class AnggotaDetailScreenState extends State<AnggotaDetailScreen> {
  late Anggota anggota;
  late TransactionProvider txnProvider;
  final MobileApiRequester _apiRequester = MobileApiRequester();

  Future<void> _deleteAnggota(Anggota anggota) async {
    try {
      final bool isConfirmed = await _showDeleteConfirmationDialog();
      if (!isConfirmed) return;

      await _apiRequester.deleteAnggota(id: anggota.id);
      Get.back();
      AppSnackBar.success("Success", "Anggota deleted successfully");
    } on DioException catch (e) {
      HelplessUtil.handleApiError(e);
    }
  }

  void _setAnggotaState(Anggota newAnggota) {
    setState(() {
      anggota = newAnggota;
    });
  }

  Future<void> _handleRefresh() async {
    txnProvider.clearTransactionList();
    txnProvider.clearSaldo();

    await Future.wait([
      txnProvider.getSaldo(anggota),
      txnProvider.getListTabunganAnggota(anggota),
    ]);
  }

  Future<bool> _showDeleteConfirmationDialog() async {
    late bool isConfirmed;
    await dialogWrapper(
      context: context,
      content: ConfirmationDialogContent(
        text: "Are you sure you want to delete this anggota?",
        onConfirmed: () {
          Get.back();
          isConfirmed = true;
        },
        onCanceled: () {
          Get.back();
          isConfirmed = false;
        },
        confirmText: "Delete",
      ),
    );
    return isConfirmed;
  }

  @override
  void initState() {
    anggota = widget.anggota;
    txnProvider = context.read<TransactionProvider>();
    txnProvider.getSaldo(anggota);
    txnProvider.getListTabunganAnggota(anggota);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg-abstract.jpg"),
                fit: BoxFit.fitHeight, // Add this line
              ),
            ),
            height: MediaQuery.of(context).size.height *
                0.5, // Set the height to 50% of the screen
          ),
          SafeArea(
            child: RefreshIndicator(
              onRefresh: _handleRefresh,
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _backButton(),
                      _popUpMenuButton(),
                    ],
                  ),
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
                  SizedBox(height: 60),
                  TransactionHistory(anggota: anggota),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _backButton() {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Get.back();
              txnProvider.clearTransactionList();
            },
          ),
        ],
      ),
    );
  }

  Widget _nameAndSaldo() {
    return Column(
      children: [
        Text(anggota.nama, style: TextStyle(fontSize: 18, color: Colors.white)),
        Consumer<TransactionProvider>(
          builder: (context, provider, child) {
            return provider.isLoadingSaldo
                ? Skeletonizer(
                    enabled: true,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextTitle(title: "Rp1.000.000"),
                    ),
                  )
                : TextTitle(
                    title: "Rp${HelplessUtil.formatNumber(provider.saldo)}",
                    color: Colors.white,
                    fontSize: 32,
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
                  color: Colors.white,
                  // color: provider.isLoadingSaldo
                  //     ? Colors.grey.shade400
                  //     : Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  padding: EdgeInsets.all(15),
                  icon: Image.asset(
                    "assets/money.png",
                    color: Colors.blue.shade900,
                    // color: provider.isLoadingSaldo
                    //     ? Colors.grey.shade100
                    //     : Colors.blue.shade900,
                  ),
                  onPressed: provider.isLoadingSaldo || provider.isLoadingList
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
          Text(
            "Create\nTxn",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
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
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.all(22),
              icon: Image.asset(
                "assets/people.png",
                color: Colors.blue.shade900,
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
          Text(
            "Anggota\nInfo",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ],
      ),
    );
  }

  PopupMenuButton<dynamic> _popUpMenuButton() {
    return PopupMenuButton(
      onSelected: (item) {
        switch (item) {
          case 'edit':
            Get.to(
              () => EditAnggotaScreen(
                updateAnggotaStateCallback: _setAnggotaState,
                anggota: anggota,
              ),
            );
            break;
          case 'delete':
            _deleteAnggota(anggota);
            break;
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 'edit',
          child: Text('Edit'),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Text('Delete'),
        ),
      ],
      position: PopupMenuPosition.under,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
      ),
    );
  }
}
