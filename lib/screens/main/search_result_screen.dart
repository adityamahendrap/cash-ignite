import 'package:color_log/color_log.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/mobile_api.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/anggota_list_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';
import 'package:progmob_magical_destroyers/widgets/anggota/anggota_list_tile_skeleton.dart';
import 'package:progmob_magical_destroyers/widgets/anggota/anggota_list_view.dart';
import 'package:progmob_magical_destroyers/widgets/app_bar_with_back_button.dart';
import 'package:progmob_magical_destroyers/widgets/data/empty_data.dart';
import 'package:progmob_magical_destroyers/widgets/data/error_fetching_data.dart';

class SearchResultScreen extends StatefulWidget {
  final String keyword;

  const SearchResultScreen({
    super.key,
    required this.keyword,
  });

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
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

  List<Anggota> _filterAnggotaList(List<Anggota> anggotaList, String keyword) {
    final List<Anggota> filteredList = anggotaList
        .where((anggota) =>
            anggota.nama.toLowerCase().contains(keyword.toLowerCase()))
        .toList();

    return filteredList;
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _anggotaList = Future.value(null);
    });
    await _getAnggotaList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getAnggotaList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackButton(
        title: "Search Result",
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: FutureBuilder(
                future: _anggotaList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return AnggotaListTileSkeleton(itemCount: 6);
                  } else if (snapshot.hasData) {
                    List<Anggota> items = snapshot.data!.anggotaList;
                    items = _filterAnggotaList(items, widget.keyword);

                    if (items.isEmpty) {
                      return Column(
                        children: [
                          _countLabel(items),
                          SizedBox(height: 20),
                          EmptyData(),
                        ],
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _countLabel(items),
                        SizedBox(height: 10),
                        AnggotaListView(
                          items: items,
                          refreshAnggotaListCallback: _handleRefresh,
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    clog.error('snaphot err: ${snapshot.error.toString()}');
                    return ErrorFetchingData();
                  }

                  return AnggotaListTileSkeleton(itemCount: 6);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _countLabel(List<Anggota> items) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorPlanet.primary.withOpacity(0.2),
            ),
            child: Text(
              "${items.length} Igniter's Found",
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Keyword: ${widget.keyword}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
