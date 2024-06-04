import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/widgets/bunga/add_setting_bunga.dart';
import 'package:progmob_magical_destroyers/widgets/wrapper/bottom_sheet_fit_content_wrapper.dart';

enum SettingBungaGridViewType { add, moreCount }

class SettingBungaGridView extends StatelessWidget {
  final SettingBungaGridViewType type;
  SettingBungaGridView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 4,
        shrinkWrap: true,
        children: <Widget>[
          _gridTileActive(),
          _gridTIle(),
          _gridTIle(),
          if (type == SettingBungaGridViewType.add)
            _gridTIleAdd(context)
          else
            _gridTIleMoreCount()
        ],
      ),
    );
  }

  Container _gridTIle() {
    return Container(
      alignment: Alignment.center,
      decoration: _containerDecoration(color: ColorPlanet.secondary),
      child: Text(
        "0.5%",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ColorPlanet.primary,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _gridTIleAdd(BuildContext context) {
    return InkWell(
      onTap: () {
        bottomSheetFitContentWrapper(
            context: context, content: AddSettingBunga());
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

  Container _gridTIleMoreCount() {
    return Container(
      alignment: Alignment.center,
      decoration: _containerDecoration(color: ColorPlanet.secondary),
      child: Text(
        "+2\nmore",
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

  Stack _gridTileActive() {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: _containerDecoration(color: ColorPlanet.primary),
          child: Text(
            "0.1%",
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
