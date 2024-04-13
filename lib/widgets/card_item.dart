import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';

class CardItem extends StatelessWidget {
  late final Map item;

  CardItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorPlanet.secondary,
                ),
                child: Center(
                  child: Text(
                    'Image ${item['id']}',
                    style: TextStyle(
                      color: ColorPlanet.primary,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 15,
                right: 15,
                child: Container(
                  padding: EdgeInsets.all(7),
                  child: Icon(
                    CupertinoIcons.heart_fill,
                    color: Colors.white,
                    size: 15,
                  ),
                  decoration: BoxDecoration(
                    color: ColorPlanet.primary,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            '${item['name']}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2),
          Row(
            children: [
              Icon(
                Icons.star_half_outlined,
                color: ColorPlanet.primary,
              ),
              SizedBox(width: 5),
              Text('${item['rating']} | '),
              SizedBox(width: 5),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: ColorPlanet.secondary,
                ),
                child: Text('${item['sold']} sold'),
              )
            ],
          ),
          Text(
            '\$${item['price']}',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
