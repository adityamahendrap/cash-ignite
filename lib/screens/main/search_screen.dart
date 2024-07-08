import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/screens/main/search_result_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool? _keyboard = Get.arguments['keyboard'];
  final _box = GetStorage();
  final _searchController = TextEditingController();
  List<String> _searchHistory = [];

  void _onSubmitted(String value) {
    if (value.trim().isEmpty) return;
    final keyword = value.trim();

    final List<String> savedSearchHistory = _box.read('searchHistory') ?? [];
    savedSearchHistory.add(keyword);
    _box.write('searchHistory', savedSearchHistory);
    setState(() {
      _searchHistory = savedSearchHistory;
    });

    Get.to(() => SearchResultScreen(keyword: keyword));
    _searchController.clear();
  }

  void _deleteSearchHistory(int index) {
    final List<String> savedSearchHistory = _box.read('searchHistory') ?? [];
    savedSearchHistory.removeAt(index);
    _box.write('searchHistory', savedSearchHistory);
    setState(() {
      _searchHistory = savedSearchHistory;
    });
  }

  void _deleteAllSearchHistory() {
    _box.remove('searchHistory');
    setState(() {
      _searchHistory = [];
    });
  }

  @override
  void initState() {
    super.initState();
    List<String> savedSearchHistory = _box.read('searchHistory') ?? [];
    setState(() {
      _searchHistory = savedSearchHistory;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   if (_keyboard == false) _showSortFilterBottomSheet(context);
    // });
  }

  // void _showSortFilterBottomSheet(BuildContext context) async {
  //   FocusManager.instance.primaryFocus?.unfocus();

  // await bottomSheetFitContentWrapper(
  //   context: context,
  //   content: SortFilter(),
  //   isHorizontalPaddingActive: false,
  // );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _searchInput(context),
              searchHistoryList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchInput(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.white,
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            autofocus: _keyboard!,
            onSubmitted: _onSubmitted,
            style: TextStyle(color: Colors.black),
            cursorColor: ColorPlanet.primary,
            decoration: InputDecoration(
              filled: true,
              hintText: 'Search igniter here...',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              fillColor: Colors.grey.shade100,
              prefixIcon: Icon(CupertinoIcons.search, color: Colors.grey),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              // suffixIcon: IconButton(
              //   onPressed: () => _showSortFilterBottomSheet(context),
              //   icon: Icon(
              //     CupertinoIcons.slider_horizontal_3,
              //     color: Colors.black,
              //   ),
              // ),
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

  Widget searchHistoryList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                ),
                onPressed: () {},
                child: _searchHistory.length == 0
                    ? Container()
                    : GestureDetector(
                        child: Text('Clear all'),
                        onTap: () => _deleteAllSearchHistory(),
                      ),
              )
            ],
          ),
          Divider(color: Colors.grey.shade300),
          _searchHistory.length == 0
              ? Column(
                  children: [
                    SizedBox(height: 10),
                    Text("You have no search history"),
                  ],
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: _searchHistory.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    index = _searchHistory.length - 1 - index;
                    return ListTile(
                      onTap: () {
                        Get.to(() =>
                            SearchResultScreen(keyword: _searchHistory[index]));
                      },
                      title: Text(_searchHistory[index]),
                      trailing: GestureDetector(
                        onTap: () => _deleteSearchHistory(index),
                        child: Icon(
                          CupertinoIcons.xmark,
                          color: Colors.black54,
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity(vertical: -2),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
