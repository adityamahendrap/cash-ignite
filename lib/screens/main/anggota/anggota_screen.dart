import 'package:color_log/color_log.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/mobile_api.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/anggota_list_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';
import 'package:progmob_magical_destroyers/screens/main/anggota/add_anggota_screen.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';
import 'package:progmob_magical_destroyers/widgets/anggota/anggota_list_tile_skeleton.dart';
import 'package:progmob_magical_destroyers/widgets/anggota/anggota_list_view.dart';
import 'package:progmob_magical_destroyers/widgets/data/empty_data.dart';
import 'package:progmob_magical_destroyers/widgets/data/error_fetching_data.dart';
import 'package:progmob_magical_destroyers/widgets/floating_action_button_add.dart';
import 'package:progmob_magical_destroyers/widgets/sort_filter.dart';
import 'package:progmob_magical_destroyers/widgets/text_title.dart';
import 'package:get/get.dart';
import 'package:progmob_magical_destroyers/screens/main/search_screen.dart';
import 'package:progmob_magical_destroyers/widgets/wrapper/bottom_sheet_fit_content_wrapper.dart';

class AnggotaScreen extends StatefulWidget {
  const AnggotaScreen({super.key});

  @override
  State<AnggotaScreen> createState() => _AnggotaScreenState();
}

class _AnggotaScreenState extends State<AnggotaScreen> {
  final MobileApiRequester _apiRequester = MobileApiRequester();
  late Future<AnggotaList?> _anggotaList;
  int _selectedSortByIndex = 0;

  void _setSortByIndex(int index) {
    setState(() {
      _selectedSortByIndex = index;
    });
  }

  List<Anggota> _sortFilterAnggotaList(
    List<Anggota> items,
    int selectedSortByIndex,
  ) {
    switch (selectedSortByIndex) {
      case 1:
        items.sort((a, b) => a.nama.compareTo(b.nama));
        break;
      case 2:
        items.sort((a, b) => b.nama.compareTo(a.nama));
        break;
      default:
        items.sort((a, b) => a.nomorInduk.compareTo(b.nomorInduk));
        break;
    }

    return items;
  }

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

  Future<void> _handleRefresh() async {
    setState(() {
      _anggotaList = Future.value(null);
    });
    await _getAnggotaList();
    setState(() {});
  }

  void _showSortFilterBottomSheet(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    await bottomSheetFitContentWrapper(
      context: context,
      content: SortFilter(
        selectedSortByIndex: _selectedSortByIndex,
        onApply: _setSortByIndex,
      ),
      isHorizontalPaddingActive: false,
    );
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
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: Container(
          // color: Color(0xFF5EB2FF),
          color: ColorPlanet.primary,
          child: CustomScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: _header()),
              SliverAppBar(
                title: _searchInput(),
                floating: true,
                pinned: true,
                titleSpacing: 0,
                toolbarHeight: 80,
                // backgroundColor: Color(0xFF5EB2FF),
                backgroundColor: ColorPlanet.primary,
              ),
              SliverToBoxAdapter(
                child: _anggotaListView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    final tempWidget = TextTitle(
      title: 'You have _ Igniters',
      color: Colors.white,
    );

    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 10),
        child: FutureBuilder(
          future: _anggotaList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return tempWidget;
            } else if (snapshot.hasData) {
              final List<Anggota> items = snapshot.data!.anggotaList;

              return TextTitle(
                title: 'You have ${items.length} Igniters',
                color: Colors.white,
              );
            } else if (snapshot.hasError) {
              clog.error('snaphot err: ${snapshot.error.toString()}');
              return tempWidget;
            }

            return tempWidget;
          },
        ),
      ),
    );
  }

  Widget _searchInput() {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 25),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(8, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            style: TextStyle(color: Colors.black),
            cursorColor: ColorPlanet.primary,
            readOnly: true,
            onTap: () {
              Get.to(
                () => SearchScreen(),
                transition: Transition.cupertinoDialog,
                arguments: {'keyboard': true},
              );
            },
            decoration: InputDecoration(
              filled: true,
              hintText: 'Search igniter here...',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              // fillColor: Colors.grey.shade100,
              fillColor: Colors.white,
              prefixIcon: Icon(CupertinoIcons.search, color: Colors.grey),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              suffixIcon: IconButton(
                icon: Icon(CupertinoIcons.slider_horizontal_3),
                color: Colors.black,
                onPressed: () => _showSortFilterBottomSheet(context),
                // onPressed: () {
                //   Get.to(
                //     () => SearchScreen(),
                //     transition: Transition.cupertinoDialog,
                //     arguments: {'keyboard': false},
                //   );
                // },
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _appbar() {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomLeft,
          //   colors: [ColorPlanet.primary, ColorPlanet.primary.withOpacity(0.8)],
          // ),
          color: ColorPlanet.primary,
        ),
      ),
      centerTitle: true,
      title: IconButton(
        icon: Container(
          height: 24,
          width: 24,
          child: Image.asset("assets/logo.png", color: Colors.white),
        ),
        onPressed: null,
      ),
    );
  }

  Widget _anggotaListView() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.7,
        maxHeight: double.infinity,
      ),
      child: Container(
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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return AnggotaListTileSkeleton(itemCount: 6);
            } else if (snapshot.hasData) {
              List<Anggota> items = snapshot.data!.anggotaList;
              items = _sortFilterAnggotaList(items, _selectedSortByIndex);

              if (items.isEmpty) {
                return EmptyData();
              }

              return AnggotaListView(
                items: items,
                refreshAnggotaListCallback: _handleRefresh,
              );
            } else if (snapshot.hasError) {
              clog.error('snaphot err: ${snapshot.error.toString()}');
              return ErrorFetchingData();
            }

            return AnggotaListTileSkeleton(itemCount: 6);
          },
        ),
      ),
    );
  }
}
