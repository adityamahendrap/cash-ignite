import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/list_setting_bunga_type.dart';
import 'package:progmob_magical_destroyers/widgets/bunga/add_setting_bunga.dart';
import 'package:progmob_magical_destroyers/widgets/wrapper/bottom_sheet_fit_content_wrapper.dart';
import 'package:skeletonizer/skeletonizer.dart';

enum SettingBungaGridViewType { add, moreCount }

class SettingBungaGridView extends StatelessWidget {
  final SettingBungaGridViewType type;
  final List<SettingBunga> items;
  final SettingBunga activeItem;
  final Function refreshListSettingBungaCallback;

  SettingBungaGridView({
    super.key,
    required this.type,
    required this.items,
    required this.activeItem,
    required this.refreshListSettingBungaCallback,
  });

  String _formatPercent(double? persen) {
    return persen.toString().replaceFirst('.', ',') + '%';
  }

  @override
  Widget build(BuildContext context) {
    // reverse items
    final reversedItems = items.reversed.toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 4,
        shrinkWrap: true,
        children: type == SettingBungaGridViewType.add
            ? _gridTilesWithAdd(context, reversedItems)
            : _gridTilesWithMoreCount(reversedItems),
      ),
    );
  }

  List<Widget> _gridTilesWithAdd(
    BuildContext context,
    List<SettingBunga> items,
  ) {
    return [
      ...items.map((item) {
        return item.id == activeItem.id
            ? _gridTileActive(item)
            : _gridTile(item);
      }).toList(),
      _gridTIleAdd(context),
    ];
  }

  List<Widget> _gridTilesWithMoreCount(List<SettingBunga> items) {
    // set active item to the first index
    items.removeWhere((item) => item.id == activeItem.id);
    items.insert(0, activeItem);

    // limit to 3 items
    List<SettingBunga> filteredItems =
        items.length > 3 ? items.sublist(0, 3) : items;

    return [
      ...filteredItems.map((item) {
        return item.id == activeItem.id
            ? _gridTileActive(item)
            : _gridTile(item);
      }).toList(),
      if (items.length >= 4) _gridTIleMoreCount(items.length - 3)
    ];
  }

  Container _gridTile(SettingBunga item) {
    return Container(
      alignment: Alignment.center,
      decoration: _containerDecoration(color: ColorPlanet.secondary),
      child: Text(
        _formatPercent(item.persen),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ColorPlanet.primary,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Stack _gridTileActive(SettingBunga item) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: _containerDecoration(color: ColorPlanet.primary),
          child: Text(
            _formatPercent(item.persen),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          child: Text(
            'Active',
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
          top: 5,
          left: 10,
        ),
      ],
    );
  }

  Widget _gridTIleAdd(BuildContext context) {
    return InkWell(
      onTap: () {
        bottomSheetFitContentWrapper(
            context: context,
            content: AddSettingBunga(
              refreshListSettingBungaCallback: refreshListSettingBungaCallback,
            ));
      },
      child: Container(
        alignment: Alignment.center,
        decoration: _containerDecoration(color: ColorPlanet.secondary),
        child: Icon(
          Icons.add,
          color: ColorPlanet.primary,
          size: 30,
        ),
      ),
    );
  }

  Container _gridTIleMoreCount(int count) {
    return Container(
      alignment: Alignment.center,
      decoration: _containerDecoration(color: ColorPlanet.secondary),
      child: Text(
        "+$count\nmore",
        textAlign: TextAlign.center,
        style: TextStyle(
          height: 1.2,
          color: ColorPlanet.primary,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  BoxDecoration _containerDecoration({Color? color}) {
    return BoxDecoration(
      color: color ?? Colors.white,
      border: Border.all(color: Colors.grey.withOpacity(0.3)),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    );
  }
}

class SettingBungaGridViewSkeleton extends StatelessWidget {
  final int? count;
  const SettingBungaGridViewSkeleton({super.key, this.count = 4});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 4,
          shrinkWrap: true,
          children: List.generate(this.count!, (index) {
            return Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.grey.withOpacity(0.3)),
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                  child: Text(
                    "0.00%",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  child: Text(
                    'Active',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  top: 5,
                  left: 10,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
