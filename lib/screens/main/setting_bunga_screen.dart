import 'package:color_log/color_log.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/mobile_api.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/list_setting_bunga_type.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';
import 'package:progmob_magical_destroyers/widgets/app_bar_with_back_button.dart';
import 'package:progmob_magical_destroyers/widgets/bunga/setting_bunga_grid_view.dart';
import 'package:progmob_magical_destroyers/widgets/data/empty_data.dart';
import 'package:progmob_magical_destroyers/widgets/data/error_fetching_data.dart';

class SettingInterestScreen extends StatefulWidget {
  const SettingInterestScreen({super.key});

  @override
  State<SettingInterestScreen> createState() => _SettingInterestScreenState();
}

class _SettingInterestScreenState extends State<SettingInterestScreen> {
  MobileApiRequester _apiRequester = MobileApiRequester();
  late Future<ListSettingBunga?> _listSettingBunga;

  Future<void> _getListOfSettingBunga() async {
    try {
      _listSettingBunga = _apiRequester.getListSettingBunga();
    } on DioException catch (e) {
      HelplessUtil.handleApiError(e);
    }
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _listSettingBunga = Future.value(null);
    });
    await _getListOfSettingBunga();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getListOfSettingBunga();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackButton(
        title: "Setting Interest",
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: ListView(
          children: [
            SizedBox(height: 5),
            FutureBuilder(
              future: _listSettingBunga,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  clog.error('Error fetching data: ${snapshot.error}');
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ErrorFetchingData(),
                  );
                } else if (snapshot.hasData) {
                  List<SettingBunga> items = snapshot.data!.settingbungas!;
                  SettingBunga activeItem = snapshot.data!.activebunga!;

                  if (items.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: EmptyData(),
                    );
                  }

                  return SettingBungaGridView(
                    type: SettingBungaGridViewType.add,
                    items: items,
                    activeItem: activeItem,
                  );
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
