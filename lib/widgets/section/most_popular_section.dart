import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/types/product_type.dart';
import 'package:progmob_magical_destroyers/widgets/product_card.dart';
import 'package:progmob_magical_destroyers/widgets/section_header.dart';

class MostPopularSection extends StatelessWidget {
  MostPopularSection({super.key});

  final items = ['Lorem', 'Ipsum', 'Dolor', 'Sit', 'Amet'];
  final activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(title: 'Most Popular'),
        _mostPopularButtons(items, activeIndex),
        SizedBox(height: 20),
        _mostPopularCards(),
      ],
    );
  }

  Widget _mostPopularCards() {
    final List<Product> products = [
      Product(
        id: '1',
        name: 'Lorem',
        price: 100,
        rating: 4.5,
        sold: 100,
      ),
      Product(
        id: '2',
        name: 'Ipsum',
        price: 200,
        rating: 4.5,
        sold: 100,
      ),
    ];

    List<ProductCard> cardItems = products
        .map((e) => ProductCard(
              item: e,
              onCardPressed: null,
            ))
        .toList();
    List<TrackSize> rowSizes =
        List.generate((products.length / 2).ceil(), (index) => auto);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        child: LayoutGrid(
          columnGap: 20,
          rowGap: 20,
          columnSizes: [1.fr, 1.fr],
          rowSizes: rowSizes,
          children: cardItems,
        ),
      ),
    );
  }

  Container _mostPopularButtons(List<String> items, int activeIndex) {
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
