import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/types/category_item_type.dart';

class CategorySection extends StatelessWidget {
  CategorySection({super.key});

  final List<CategoryItem> categoryItems = [
    CategoryItem(name: 'Lorem', icon: Icons.food_bank),
    CategoryItem(name: 'Ipsum', icon: Icons.forest),
    CategoryItem(name: 'Dolor', icon: Icons.ac_unit_sharp),
    CategoryItem(name: 'Sit', icon: Icons.airplanemode_active),
    CategoryItem(name: 'Amet', icon: Icons.airport_shuttle),
    CategoryItem(name: 'Sos', icon: Icons.account_tree),
    CategoryItem(name: 'Dapibus', icon: Icons.add_business),
    CategoryItem(name: 'Consectetur', icon: Icons.add_location),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: categoryItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 30,
                mainAxisSpacing: 40,
              ),
              itemBuilder: (context, index) {
                final item = categoryItems[index];
                return Center(
                  child: Wrap(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: ColorPlanet.secondary,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child:
                                  Icon(item.icon, color: ColorPlanet.primary),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            item.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
