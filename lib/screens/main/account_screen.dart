import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/screens/account/edit_profile.dart';
import 'package:progmob_magical_destroyers/screens/account/notification.dart';
import 'package:progmob_magical_destroyers/widgets/text_title.dart';

class Account extends StatefulWidget {
  Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool isLightMode = true;

  List _items = [
    {
      'text': 'Edit Profile',
      'icon': Icons.person_outline,
      'screen': EditProfile()
    },
    {'text': 'Address', 'icon': Icons.location_on_outlined, 'screen': null},
    {
      'text': 'Notification',
      'icon': Icons.notifications_none_outlined,
      'screen': Notification_()
    },
    {'text': 'Payment', 'icon': Icons.payment_outlined, 'screen': null},
    {'text': 'Security', 'icon': Icons.security_outlined, 'screen': null},
    {'text': 'Logout', 'icon': Icons.logout, 'screen': null},
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> _itemTiles = _items.map((e) => _mainListTile(e)).toList();
    Widget _languageItemTile = _languageListTile();
    Widget _lightModeItemTile = _lightModeListTile();

    _itemTiles.insert(5, _lightModeItemTile);
    _itemTiles.insert(6, _languageItemTile);

    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            Center(child: _profilePicture()),
            SizedBox(height: 20),
            TextTitle(title: 'Aditya Mahendra'),
            SizedBox(height: 5),
            Text('+62 812 3456 7890'),
            SizedBox(height: 20),
            Divider(color: Colors.grey.shade300),
            ..._itemTiles,
          ]),
        ),
      ),
    );
  }

  Widget _mainListTile(Map item) {
    final trailing =
        item['text'] == 'Logout' ? null : CupertinoIcons.chevron_right;
    final color = item['text'] == 'Logout' ? Colors.red : Colors.black;

    return ListTile(
      leading: Icon(item['icon'], color: color),
      title: Text(
        item['text'],
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: color,
        ),
      ),
      contentPadding: EdgeInsets.zero,
      trailing: Icon(trailing),
      visualDensity: VisualDensity(vertical: -2),
      onTap: () {
        if (item['screen'] != null) {
          Get.to(() => item['screen'] as Widget);
        }
      },
    );
  }

  Widget _languageListTile() {
    return ListTile(
      leading: Icon(Icons.language_outlined),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Language',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Text(
            'English (US)',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ],
      ),
      trailing: Icon(CupertinoIcons.chevron_right),
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity(vertical: -2),
      onTap: () => null,
    );
  }

  Widget _lightModeListTile() {
    return ListTile(
      leading: Icon(Icons.light_mode_outlined),
      title: Text(
        'Light Mode',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      trailing: Switch(
        value: isLightMode,
        activeColor: ColorPlanet.primary,
        onChanged: (bool value) {
          setState(() {
            isLightMode = value;
            print(isLightMode ? 'Light Mode' : 'Dark Mode');
          });
        },
      ),
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity(vertical: -2),
      onTap: () => setState(() {
        isLightMode = !isLightMode;
      }),
    );
  }

  Stack _profilePicture() {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: ColorPlanet.primary,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        icon: Container(
          height: 24,
          width: 24,
          child: Image.asset("assets/logo.png", color: ColorPlanet.primary),
        ),
        onPressed: null,
      ),
      centerTitle: true,
      title: Text(
        'Account',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
