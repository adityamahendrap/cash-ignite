import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SortFilter extends StatefulWidget {
  SortFilter({super.key});

  @override
  State<SortFilter> createState() => _SortFilterState();
}

class _SortFilterState extends State<SortFilter> {
  SfRangeValues _values = SfRangeValues(40.0, 80.0);

  List<String> categories = ['All', 'T-Shirt', 'Shoes', 'Pants', 'Hat'];
  List<String> genders = ['All', 'Men', 'Women'];
  List<String> sortBy = [
    'Newest',
    'Popular',
    'Price: Low to High',
    'Price: High to Low'
  ];
  List<String> retings = ['⭐All', '⭐5', '⭐4', '⭐3', '⭐2', '⭐1'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text('Sort & Filter',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 5),
        Divider(color: Colors.grey.shade300),
        SizedBox(height: 10),
        _sortFilterText('Category'),
        SizedBox(height: 10),
        _sortFilterButtons(categories, 0),
        SizedBox(height: 10),
        _sortFilterText('Gender'),
        SizedBox(height: 10),
        _sortFilterButtons(genders, 0),
        SizedBox(height: 10),
        _sortFilterText('Price Range'),
        SfRangeSlider(
          min: 0.0,
          max: 100.0,
          values: _values,
          interval: 20,
          showTicks: true,
          showLabels: true,
          enableTooltip: true,
          minorTicksPerInterval: 1,
          onChanged: (SfRangeValues values) {
            setState(() {
              _values = values;
            });
          },
        ),
        SizedBox(height: 10),
        _sortFilterText('Sort By'),
        SizedBox(height: 10),
        _sortFilterButtons(sortBy, 0),
        SizedBox(height: 10),
        _sortFilterText('Rating'),
        SizedBox(height: 10),
        _sortFilterButtons(retings, 0)
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

  Container _sortFilterButtons(List<String> items, int activeIndex) {
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
            onPressed: () {},
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
