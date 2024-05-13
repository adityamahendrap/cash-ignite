import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/widgets/app_bar_with_back_button.dart';

class LanguageScreen extends StatefulWidget {
  LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late List languages = [];
  String _selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  Future<void> loadJson() async {
    final String jsonString =
        await rootBundle.loadString('lib/configs/constants/languages.json');
    final data = jsonDecode(jsonString);
    setState(() {
      languages = data;
    });
  }

  void _changeLanguage(String name) {
    setState(() {
      _selectedLanguage = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackButton(title: 'Language', centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: languages.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                languages[index]['name'],
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              onTap: () => _changeLanguage(languages[index]['name']),
              contentPadding: EdgeInsets.zero,
              trailing: Transform.scale(
                scale: 1.2,
                child: Radio(
                  visualDensity: VisualDensity.compact,
                  value: languages[index]['name'],
                  groupValue: _selectedLanguage,
                  onChanged: (value) => _changeLanguage(value.toString()),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
