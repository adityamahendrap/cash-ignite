import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:progmob_magical_destroyers/screens/main/main_screen.dart';
import 'package:progmob_magical_destroyers/widgets/card_item.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(),
              _specialOffers(),
              SizedBox(height: 20),
              _categories(),
              SizedBox(height: 40),
              _mostPopular(),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(backgroundColor: ColorPlanet.primary),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Good morning, 👋',
                        style: TextStyle(color: Colors.grey.shade800)),
                    Text(
                      'Aditya Mahendra',
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
              _notificationButton(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.bookmark_border_outlined),
                color: Colors.black,
              ),
            ],
          ),
          SizedBox(height: 15),
          _searchInput(),
        ],
      ),
    );
  }

  Stack _notificationButton() {
    return Stack(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications_none_outlined),
          color: Colors.black,
        ),
        Positioned(
          top: 11,
          right: 13,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  TextField _searchInput() {
    return TextField(
      style: TextStyle(color: Colors.black),
      cursorColor: ColorPlanet.primary,
      decoration: InputDecoration(
        filled: true,
        hintText: 'Search',
        hintStyle: TextStyle(color: Colors.grey),
        border: InputBorder.none,
        fillColor: Colors.grey.shade100,
        prefixIcon: Icon(CupertinoIcons.search, color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
        suffixIcon: Icon(
          CupertinoIcons.slider_horizontal_3,
          color: Colors.black,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }

  Widget _specialOffers() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Special Offers',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              _seeAllButton()
            ],
          ),
        ),
        _carousel(),
      ],
    );
  }

  Widget _carousel() {
    return FlutterCarousel(
      options: CarouselOptions(
        height: 200.0,
        showIndicator: true,
        slideIndicator: CircularSlideIndicator(
          currentIndicatorColor: ColorPlanet.primary,
          padding: EdgeInsets.only(bottom: 10),
          indicatorBackgroundColor: Colors.grey.shade300,
        ),
        floatingIndicator: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        reverse: false,
        padEnds: true,
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: ColorPlanet.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  'Image $i',
                  style: TextStyle(fontSize: 16.0, color: ColorPlanet.primary),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _categories() {
    final items = [
      'Lorem',
      'Ipsum',
      'Dolor',
      'Sit',
      'Amet',
      'Elit',
      'Sed',
      'Dod',
    ];
    final icons = [
      Icons.food_bank,
      Icons.local_drink,
      Icons.cake,
      Icons.local_cafe,
      Icons.fastfood,
      Icons.food_bank,
      Icons.local_drink,
      Icons.cake,
    ];

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 30,
                mainAxisSpacing: 40,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
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
                              child: Icon(icons[index],
                                  color: ColorPlanet.primary),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            item,
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

  Widget _mostPopular() {
    final items = ['Lorem', 'Ipsum', 'Dolor', 'Sit', 'Amet'];
    final activeIndex = 0;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Most Popular',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              _seeAllButton()
            ],
          ),
        ),
        _mostPopularButtons(items, activeIndex),
        SizedBox(height: 20),
        _mostPopularCards(),
      ],
    );
  }

  Widget _mostPopularCards() {
    final items = [
      {
        'id': '1',
        'name': 'Lorem',
        'price': 100,
        'rating': 4.5,
        'sold': 100,
      },
      {
        'id': '2',
        'name': 'Ipsum',
        'price': 200,
        'rating': 4.5,
        'sold': 100,
      },
    ];

    List<CardItem> cardItems =
        items.map((item) => CardItem(item: item)).toList();
    List<TrackSize> rowSizes =
        List.generate((items.length / 2).ceil(), (index) => auto);

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

  TextButton _seeAllButton() {
    return TextButton(
      onPressed: () {},
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
    );
  }
}
