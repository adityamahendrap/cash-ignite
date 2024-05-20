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
import 'package:progmob_magical_destroyers/screens/savings_loan/add_anggota_screen.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';
import 'package:progmob_magical_destroyers/widgets/anggota/anggota_list_tile_skeleton.dart';
import 'package:progmob_magical_destroyers/widgets/anggota/anggota_list_view.dart';
import 'package:progmob_magical_destroyers/widgets/app_bar_with_logo.dart';
import 'package:progmob_magical_destroyers/widgets/app_snack_bar.dart';
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
  final MoblieApiRequester _apiRequester = MoblieApiRequester();
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
      content: Column(
        children: [
          SizedBox(height: 20),
          Text('Are you sure you want to delete this anggota?'),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                  isConfirmed = false;
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                  isConfirmed = true;
                },
                child: Text('Delete'),
              ),
            ],
          ),
        ],
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
      appBar: AppBarWithLogo(title: 'All Saver & Loaner'),
      floatingActionButton: FloatingActionButtonAdd(
        onPressed: () => Get.to(
          () => AddAnggotaScreen(addAnggotaCallback: _addAnggota),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _anggotaListView(),
          ],
        ),
      ),
    );
  }

  Widget _anggotaListView() {
    return FutureBuilder(
      future: _anggotaList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Anggota> items = snapshot.data!.anggotaList;

          if (items.isEmpty) {
            return EmptyData();
          }

          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                margin: EdgeInsets.only(right: 20, left: 20, top: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorPlanet.secondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "You have ${items.length} Sls",
                  style: TextStyle(color: ColorPlanet.primary, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 15),
              AnggotaListView(
                items: items,
                updateAnggotaCallback: _updateAnggota,
                deleteAnggotaCallback: _deleteAnggota,
              )
            ],
          );
        } else if (snapshot.hasError) {
          clog.error('snaphot err: ${snapshot.error.toString()}');
          return ErrorFetchingData();
        }

        return AnggotaListTileSkeleton(itemCount: 8);
      },
    );
  }
}
