import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/widgets/full_width_button.dart';

class SortFilter extends StatefulWidget {
  final int selectedSortByIndex;
  final Function(int) onApply;

  SortFilter({
    super.key,
    required this.selectedSortByIndex,
    required this.onApply,
  });

  @override
  State<SortFilter> createState() => _SortFilterState();
}

class _SortFilterState extends State<SortFilter> {
  List<String> _sortBy = [
    'Default',
    'Name A-Z',
    'Name Z-A',
  ];

  late int _activeButtonSortByIndex = widget.selectedSortByIndex;

  void _onSortByButtonPressed(int index) {
    setState(() {
      _activeButtonSortByIndex = index;
    });
  }

  void _apply() {
    widget.onApply(_activeButtonSortByIndex);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text('Sort & Filter',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        _sortFilterText('Sort By'),
        SizedBox(height: 10),
        _sortFilterButtons(
            items: _sortBy, activeIndex: _activeButtonSortByIndex),
        SizedBox(height: 40),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: FullWidthButton(
            type: FullWidthButtonType.primary,
            text: "Apply",
            onPressed: () => _apply(),
          ),
        )
      ],
    );
  }

  Padding _sortFilterText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  Container _sortFilterButtons({
    required List<String> items,
    required int activeIndex,
  }) {
    return Container(
      height: 35,
      child: ListView.separated(
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        padding: EdgeInsets.symmetric(horizontal: 20),
        separatorBuilder: (context, index) => SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = items[index];
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  activeIndex == index ? ColorPlanet.primary : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: ColorPlanet.primary, width: 2),
              ),
            ),
            onPressed: () => _onSortByButtonPressed(index),
            child: Text(
              item,
              style: TextStyle(
                color:
                    activeIndex == index ? Colors.white : ColorPlanet.primary,
                fontSize: 16,
              ),
            ),
          );
        },
      ),
    );
  }
}
