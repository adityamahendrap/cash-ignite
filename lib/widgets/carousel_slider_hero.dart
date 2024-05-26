import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';

class CarouselSliderHero extends StatelessWidget {
  final List<String> pathImages;

  CarouselSliderHero({
    super.key,
    required this.pathImages,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel(
      options: CarouselOptions(
        height: 200.0,
        showIndicator: true,
        slideIndicator: CircularSlideIndicator(
          currentIndicatorColor: ColorPlanet.primary,
          padding: EdgeInsets.only(bottom: 10),
          indicatorBackgroundColor: Colors.white,
          indicatorBorderColor: Colors.white,
          indicatorBorderWidth: 1,
          // indicatorBackgroundColor: Colors.grey.shade300,
        ),
        floatingIndicator: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 10),
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        reverse: false,
        padEnds: true,
      ),
      items: pathImages.map((path) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: ColorPlanet.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  path,
                  fit: BoxFit.cover,
                ),
              ),

              // child: Center(
              //   child: Text(
              //     path,
              //     style: TextStyle(fontSize: 16.0, color: ColorPlanet.primary),
              //   ),
              // ),
            );
          },
        );
      }).toList(),
    );
  }
}
