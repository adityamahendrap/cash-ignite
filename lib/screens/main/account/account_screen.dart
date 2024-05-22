import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/controllers/auth_controller.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/user_type.dart';
import 'package:progmob_magical_destroyers/screens/main/account/address/address_screen.dart';
import 'package:progmob_magical_destroyers/screens/main/account/edit_profile.dart';
import 'package:progmob_magical_destroyers/screens/main/account/language_screen.dart';
import 'package:progmob_magical_destroyers/screens/main/account/notification_screen.dart';
import 'package:progmob_magical_destroyers/screens/main/account/security_screen.dart';
import 'package:progmob_magical_destroyers/types/account_item_type.dart';
import 'package:progmob_magical_destroyers/widgets/app_bar_with_logo.dart';
import 'package:progmob_magical_destroyers/widgets/profile_picture.dart';
import 'package:progmob_magical_destroyers/widgets/text_title.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isLightMode = true;

  final AuthController _authController = AuthController();
  final GetStorage _box = GetStorage();
  late User _user;

  @override
  void initState() {
    super.initState();
    _user = User.fromJson(_box.read('user'));
  }

  List<AccountItem> _accountItems = [
    AccountItem(
      text: 'Edit Profile',
      icon: Icons.person_outline,
      screen: EditProfileScreen(),
    ),
    // AccountItem(
    //   text: 'Address',
    //   icon: Icons.location_on_outlined,
    //   screen: AddressScreen(),
    // ),
    AccountItem(
      text: 'Notification',
      icon: Icons.notifications_none_outlined,
      screen: NotificationScreen(),
    ),
    AccountItem(
      text: 'Security',
      icon: Icons.security_outlined,
      screen: SecurityScreen(),
    ),
    AccountItem(
      text: 'Logout',
      icon: Icons.logout,
      screen: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> _accountItemTiles =
        _accountItems.map((e) => _mainListTile(e)).toList();
    Widget _languageItemTile = _languageListTile();
    Widget _lightModeItemTile = _lightModeListTile();

    _accountItemTiles.insert(_accountItems.length - 1, _lightModeItemTile);
    _accountItemTiles.insert(_accountItems.length - 1, _languageItemTile);

    return Scaffold(
      appBar: AppBarWithLogo(title: 'Account'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(child: ProfilePicture()),
            SizedBox(height: 20),
            TextTitle(title: _user.name),
            SizedBox(height: 5),
            Text(_user.email),
            SizedBox(height: 20),
            Divider(color: Colors.grey.shade300),
            ..._accountItemTiles,
          ],
        ),
      ),
    );
  }

  Widget _mainListTile(AccountItem item) {
    final trailing =
        item.text == 'Logout' ? null : CupertinoIcons.chevron_right;
    final color = item.text == 'Logout' ? Colors.red : Colors.black;

    return ListTile(
      leading: Icon(item.icon, color: color),
      title: Text(
        item.text,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: color,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      trailing: Icon(trailing),
      visualDensity: VisualDensity(vertical: -2),
      onTap: () {
        if (item.screen != null) {
          Get.to(() => item.screen as Widget);
        } else {
          _authController.signOut();
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
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      visualDensity: VisualDensity(vertical: -2),
      onTap: () => Get.to(() => LanguageScreen()),
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
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      visualDensity: VisualDensity(vertical: -2),
      onTap: () => setState(() {
        isLightMode = !isLightMode;
      }),
    );
  }
}
