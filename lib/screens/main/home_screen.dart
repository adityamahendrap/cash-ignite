import 'package:color_log/color_log.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/configs/constants/app_config.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/mobile_api.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/user_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/anggota_list_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/list_setting_bunga_type.dart';
import 'package:progmob_magical_destroyers/controllers/profile_provider.dart';
import 'package:progmob_magical_destroyers/screens/main/search_screen.dart';
import 'package:progmob_magical_destroyers/screens/main/setting_bunga_screen.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';
import 'package:progmob_magical_destroyers/widgets/anggota/anggota_list_tile_skeleton.dart';
import 'package:progmob_magical_destroyers/widgets/anggota/anggota_list_view.dart';
import 'package:progmob_magical_destroyers/widgets/bunga/setting_bunga_grid_view.dart';
import 'package:progmob_magical_destroyers/widgets/data/empty_data.dart';
import 'package:progmob_magical_destroyers/widgets/data/error_fetching_data.dart';
import 'package:progmob_magical_destroyers/widgets/notification_button.dart';
import 'package:progmob_magical_destroyers/widgets/photo_view.dart';
import 'package:progmob_magical_destroyers/widgets/carousel_slider_hero.dart';
import 'package:progmob_magical_destroyers/widgets/section_header.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final Function(int)? changeBottomBarIndexCallback;
  HomeScreen({super.key, this.changeBottomBarIndexCallback});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GetStorage _box = GetStorage();
  final MobileApiRequester _apiRequester = MobileApiRequester();

  late User _user;
  late Future<AnggotaList?> _anggotaList;
  late Future<ListSettingBunga?> _listSettingBunga;

  Future<void> _getAnggotaList() async {
    try {
      _anggotaList = _apiRequester.getAnggotaList();
      await _anggotaList; // Wait for the Future to complete
    } on DioException catch (e) {
      HelplessUtil.handleApiError(e);
    }
  }

  Future<void> _getListOfSettingBunga() async {
    try {
      _listSettingBunga = _apiRequester.getListSettingBunga();
    } on DioException catch (e) {
      HelplessUtil.handleApiError(e);
    }
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _anggotaList = Future.value(null);
      _listSettingBunga = Future.value(null);
    });
    Future.wait([
      _getAnggotaList(),
      _getListOfSettingBunga(),
    ]);
    setState(() {});
  }

  Future<void> _refreshListBunga() async {
    setState(() {
      _listSettingBunga = Future.value(null);
    });
    await _getListOfSettingBunga();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _user = User.fromJson(_box.read('user'));
    _getAnggotaList();
    _getListOfSettingBunga();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: CustomScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.only(bottom: 10),
                sliver: SliverToBoxAdapter(
                  child: _header(),
                ),
              ),
              SliverAppBar(
                title: _searchInput(),
                floating: true,
                pinned: true,
                titleSpacing: 0,
                toolbarHeight: 80,
                surfaceTintColor: Colors.white,
              ),
              SliverPadding(
                padding: EdgeInsets.only(bottom: 15, top: 5),
                sliver: SliverToBoxAdapter(
                  child: _hero(),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: 10, bottom: 15),
                sliver: SliverToBoxAdapter(
                  child: _settingBungaGridView(),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: 10),
                sliver: SliverToBoxAdapter(
                  child: _anggotaListView(),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: 20),
                sliver: SliverToBoxAdapter(child: Container()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  print('Profile picture pressed');
                  Get.to(() => PhotoView(
                      image: context.watch<ProfileProvider>().imageProvider));
                },
                child: CircleAvatar(
                  backgroundImage:
                      context.watch<ProfileProvider>().imageProvider,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Good ${HelplessUtil.getTimeOfDay()}, 👋',
                        style: TextStyle(color: Colors.grey.shade800)),
                    Text(
                      _user.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              NotificationButton(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.bookmark_border_outlined),
                color: Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _searchInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.white,
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
              fillColor: Colors.grey.shade100,
              prefixIcon: Icon(CupertinoIcons.search, color: Colors.grey),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              suffixIcon: IconButton(
                icon: Icon(CupertinoIcons.slider_horizontal_3),
                color: Colors.black,
                onPressed: () {
                  Get.to(
                    () => SearchScreen(),
                    transition: Transition.cupertinoDialog,
                    arguments: {'keyboard': false},
                  );
                },
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _hero() {
    return Column(
      children: [
        SectionHeader(title: AppConfig.APP_NAME, showButton: false),
        SizedBox(height: 10),
        CarouselSliderHero(pathImages: [
          'assets/slider_1.png',
          'assets/slider_2.png',
          'assets/slider_3.png',
        ]),
      ],
    );
  }

  Widget _settingBungaGridView() {
    return Column(
      children: [
        SectionHeader(
          title: 'Setting Interest',
          onSeeAll: () async {
            await Get.to(() => SettingInterestScreen());
            _refreshListBunga();
          },
        ),
        SizedBox(height: 5),
        FutureBuilder(
          future: _listSettingBunga,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SettingBungaGridViewSkeleton();
            } else if (snapshot.hasError) {
              return Container(
                padding: EdgeInsets.only(top: 20),
                child: ErrorFetchingData(),
              );
            } else if (snapshot.hasData) {
              List<SettingBunga> items = snapshot.data!.settingbungas!;
              SettingBunga activeItem = snapshot.data!.activebunga!;

              if (items.isEmpty) {
                return Container(
                  padding: EdgeInsets.only(top: 20),
                  child: EmptyData(),
                );
              }

              return SettingBungaGridView(
                type: SettingBungaGridViewType.moreCount,
                items: items,
                activeItem: activeItem,
                refreshListSettingBungaCallback: _handleRefresh,
              );
            }

            return SettingBungaGridViewSkeleton();
          },
        ),
      ],
    );
  }

  Padding _anggotaListViewHeader() {
    return Padding(
      padding: EdgeInsets.only(bottom: 5, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text('Igniters',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(width: 10),
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: ColorPlanet.secondary,
                ),
                padding: EdgeInsets.all(5),
                child: FutureBuilder(
                  future: _anggotaList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text(
                        '...',
                        style:
                            TextStyle(fontSize: 16, color: ColorPlanet.primary),
                      );
                    } else if (snapshot.hasData) {
                      return Text(
                        '${snapshot.data!.anggotaList.length}',
                        style:
                            TextStyle(fontSize: 16, color: ColorPlanet.primary),
                      );
                    }

                    return Text(
                      '...',
                      style:
                          TextStyle(fontSize: 16, color: ColorPlanet.primary),
                    );
                  },
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () => widget.changeBottomBarIndexCallback!(1),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                EdgeInsets.zero,
              ),
            ),
            child: Text(
              'See all',
              style: TextStyle(
                color: ColorPlanet.primary,
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _anggotaListView() {
    return Column(
      children: [
        _anggotaListViewHeader(),
        FutureBuilder(
          future: _anggotaList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return AnggotaListTileSkeleton(itemCount: 3);
            } else if (snapshot.hasData) {
              final List<Anggota> items = snapshot.data!.anggotaList;

              if (items.isEmpty) {
                return EmptyData();
              }

              return Column(
                children: [
                  AnggotaListView(
                    items: items,
                    refreshAnggotaListCallback: _handleRefresh,
                    limitItems: true,
                  ),
                  items.length >= 3
                      ? Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          margin: EdgeInsets.only(right: 20, left: 20, top: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorPlanet.secondary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "You're viewing the top 3 Igniters",
                            style: TextStyle(
                                color: ColorPlanet.primary, fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Container(),
                ],
              );
            } else if (snapshot.hasError) {
              clog.error('snaphot err: ${snapshot.error.toString()}');
              return Container(
                margin: EdgeInsets.only(top: 20),
                child: ErrorFetchingData(),
              );
            }

            return AnggotaListTileSkeleton(itemCount: 3);
          },
        ),
      ],
    );
  }
}
