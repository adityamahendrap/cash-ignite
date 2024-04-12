import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:progmob_magical_destroyers/screens/main/main_screen.dart';

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

  // Widget _header() {
  //   return Container(
  //     padding: EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
  //     decoration: BoxDecoration(
  //       // color: Color(0xFF14141e),
  //       color: Color(0xFF14141e),
  //       borderRadius: BorderRadius.only(
  //         bottomLeft: Radius.circular(25),
  //         bottomRight: Radius.circular(25),
  //       ),
  //     ),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             CircleAvatar(backgroundColor: Colors.white),
  //             SizedBox(width: 10),
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text('Good morning,', style: TextStyle(color: Colors.grey)),
  //                   Text(
  //                     'John Doe',
  //                     maxLines: 1,
  //                     overflow: TextOverflow.ellipsis,
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 24,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Stack(
  //               children: [
  //                 IconButton(
  //                   onPressed: () {},
  //                   icon: Icon(Icons.notifications_none_outlined),
  //                   color: Colors.grey,
  //                 ),
  //                 Positioned(
  //                   top: 11,
  //                   right: 13,
  //                   child: Container(
  //                     width: 10,
  //                     height: 10,
  //                     decoration: BoxDecoration(
  //                       color: Colors.red,
  //                       shape: BoxShape.circle,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             IconButton(
  //               onPressed: () {},
  //               icon: Icon(Icons.bookmark_border_outlined),
  //               color: Colors.grey,
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 15),
  //         Row(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Icon(
  //               Icons.search,
  //               color: Colors.white,
  //             ),
  //             SizedBox(width: 10),
  //             Expanded(
  //               child: _searchInput(),
  //             ),
  //             IconButton(
  //               onPressed: () {},
  //               icon: Icon(
  //                 Icons.menu_rounded,
  //                 color: ColorPlanet.secondary,
  //               ),
  //             )
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }

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
        prefixIcon: Icon(Icons.search, color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
        // filter icon
        suffixIcon: Icon(Icons.filter_list, color: Colors.black),
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
      'Do',
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

  // Widget _categories() {
  //   final items = [
  //     {'icon': Icons.food_bank, 'title': 'Food', 'color': Colors.blueGrey},
  //     {
  //       'icon': Icons.local_drink,
  //       'title': 'Drink',
  //       'color': Colors.greenAccent
  //     },
  //     {'icon': Icons.cake, 'title': 'Cake', 'color': Colors.pinkAccent},
  //     {'icon': Icons.local_cafe, 'title': 'Cafe', 'color': Colors.brown},
  //     {
  //       'icon': Icons.fastfood,
  //       'title': 'Fast Food',
  //       'color': Colors.orangeAccent
  //     },
  //   ];

  //   return Column(
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 20),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text('Categories',
  //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
  //             _seeAllButton()
  //           ],
  //         ),
  //       ),
  //       Container(
  //         height: 120,
  //         child: ListView.separated(
  //           shrinkWrap: false,
  //           scrollDirection: Axis.horizontal,
  //           itemCount: items.length,
  //           padding: EdgeInsets.symmetric(horizontal: 20),
  //           separatorBuilder: (context, index) => SizedBox(width: 10),
  //           itemBuilder: (context, index) {
  //             final item = items[index];
  //             return Container(
  //               width: 100,
  //               decoration: BoxDecoration(
  //                 color: item['color'] as Color,
  //                 borderRadius: BorderRadius.circular(20),
  //               ),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Icon(item['icon'] as IconData, color: Colors.black),
  //                   Text(
  //                     item['title'] as String,
  //                     style: TextStyle(color: Colors.black, fontSize: 20),
  //                   )
  //                 ],
  //               ),
  //             );
  //           },
  //         ),
  //       )
  //     ],
  //   );
  // }

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
        Container(
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
                    color: activeIndex == index
                        ? Colors.white
                        : ColorPlanet.primary,
                    fontSize: 16,
                  ),
                ),
              );
            },
          ),
        )
      ],
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
