import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/widgets/app_bar_with_back_button.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackButton(title: 'Edit Profile', centerTitle: false),
    );
  }
}
