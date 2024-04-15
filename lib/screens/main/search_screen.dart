import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _searchInput(),
              _searchHistory(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.white,
      child: Column(
        children: [
          TextField(
            autofocus: true,
            style: TextStyle(color: Colors.black),
            cursorColor: ColorPlanet.primary,
            decoration: InputDecoration(
              filled: true,
              hintText: 'Search products skibidi ...',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              fillColor: Colors.grey.shade100,
              prefixIcon: Icon(CupertinoIcons.search, color: Colors.grey),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              suffixIcon: Icon(
                CupertinoIcons.slider_horizontal_3,
                color: Colors.black,
              ),
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

  Widget _searchHistory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
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
                child: Text(
                  'Clear all',
                ),
              )
            ],
          ),
          Divider(color: Colors.grey.shade300),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Majogari $index'),
                trailing: Icon(CupertinoIcons.xmark, color: Colors.black54),
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
