import 'package:color_log/color_log.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/mobile_api.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/anggota_list_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';
import 'package:progmob_magical_destroyers/screens/main/anggota/add_anggota_screen.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';
import 'package:progmob_magical_destroyers/widgets/anggota/anggota_list_tile_skeleton.dart';
import 'package:progmob_magical_destroyers/widgets/anggota/anggota_list_view.dart';
import 'package:progmob_magical_destroyers/widgets/app_bar_with_logo.dart';
import 'package:progmob_magical_destroyers/widgets/app_snack_bar.dart';
import 'package:progmob_magical_destroyers/widgets/confirmation_dialog_content.dart';
import 'package:progmob_magical_destroyers/widgets/data/empty_data.dart';
import 'package:progmob_magical_destroyers/widgets/data/error_fetching_data.dart';
import 'package:progmob_magical_destroyers/widgets/floating_action_button_add.dart';
import 'package:progmob_magical_destroyers/widgets/wrapper/dialog_wrapper.dart';
import 'package:get/get.dart';

class AnggotaScreen extends StatefulWidget {
  const AnggotaScreen({super.key});

  @override
  State<AnggotaScreen> createState() => _AnggotaScreenState();
}

class _AnggotaScreenState extends State<AnggotaScreen> {
  final MobileApiRequester _apiRequester = MobileApiRequester();
  late Future<AnggotaList?> _anggotaList;

  Future<void> _getAnggotaList() async {
    try {
      _anggotaList = _apiRequester.getAnggotaList();
      await _anggotaList; // Wait for the Future to complete
    } on DioException catch (e) {
      HelplessUtil.handleApiError(e);
    }
  }

  Future<void> _addAnggota(Anggota anggota) async {
    try {
      await _apiRequester.addAnggota(
        nomorInduk: anggota.nomorInduk,
        nama: anggota.nama,
        tglLahir: anggota.tglLahir,
        telepon: anggota.telepon,
        alamat: anggota.alamat,
      );
      await _getAnggotaList();
      setState(() {}); // Rebuild the widget tree to reflect the updated list
    } on DioException catch (e) {
      throw e;
    }
  }

  Future<void> _updateAnggota(Anggota anggota) async {
    try {
      await _apiRequester.updateAnggota(
        id: anggota.id!,
        nomorInduk: anggota.nomorInduk,
        nama: anggota.nama,
        tglLahir: anggota.tglLahir,
        telepon: anggota.telepon,
        alamat: anggota.alamat,
        status: anggota.statusAktif ?? true,
      );
      await _getAnggotaList();
      setState(() {}); // Rebuild the widget tree to reflect the updated list
    } on DioException catch (e) {
      throw e;
    }
  }

  Future<void> _deleteAnggota(Anggota anggota) async {
    final bool isConfirmed = await _showDeleteConfirmationDialog();
    if (!isConfirmed) return;

    EasyLoading.show();
    try {
      await _apiRequester.deleteAnggota(id: anggota.id);
      await _getAnggotaList();
      setState(() {}); // Rebuild the widget tree to reflect the updated list
      AppSnackBar.success('Success', 'Anggota deleted successfully!');
    } on DioException catch (e) {
      HelplessUtil.handleApiError(e);
    } finally {
      EasyLoading.dismiss();
    }
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
    super.initState();
    _getAnggotaList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      floatingActionButton: FloatingActionButtonAdd(
        onPressed: () => Get.to(
          () => AddAnggotaScreen(addAnggotaCallback: _addAnggota),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: ColorPlanet.primary,
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topLeft,
              colors: [
                ColorPlanet.primary,
                ColorPlanet.primary.withOpacity(0.8)
              ],
            ),
          ),
          child: Column(
            children: [
              _boxHeader(),
              _anggotaListView(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appbar() {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            colors: [ColorPlanet.primary, ColorPlanet.primary.withOpacity(0.8)],
          ),
        ),
      ),
      leading: IconButton(
        icon: Container(
          height: 24,
          width: 24,
          child: Image.asset("assets/logo.png", color: Colors.white),
        ),
        onPressed: null,
      ),
      centerTitle: true,
      title: Text(
        "All Saver & Loaner",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Container _boxHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      margin: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 25),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorPlanet.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        "You have ... Sls",
        style: TextStyle(color: ColorPlanet.primary, fontSize: 15),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _anggotaListView() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          // topRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.only(top: 25),
      child: FutureBuilder(
        future: _anggotaList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Anggota> items = snapshot.data!.anggotaList;

            if (items.isEmpty) {
              return EmptyData();
            }

            return AnggotaListView(
              items: items,
              updateAnggotaCallback: _updateAnggota,
              deleteAnggotaCallback: _deleteAnggota,
            );
          } else if (snapshot.hasError) {
            clog.error('snaphot err: ${snapshot.error.toString()}');
            return ErrorFetchingData();
          }

          return AnggotaListTileSkeleton(itemCount: 6);
        },
      ),
    );
  }
}
