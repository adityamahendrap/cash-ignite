import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/widgets/app_bar_with_back_button.dart';
import 'package:progmob_magical_destroyers/widgets/bunga/setting_bunga_grid_view.dart';

class SettingInterestScreen extends StatelessWidget {
  const SettingInterestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackButton(
        title: "Setting Interest",
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SettingBungaGridView(
        type: SettingBungaGridViewType.add,
      ),
    );
  }
}
