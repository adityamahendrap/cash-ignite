import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/screens/main/account/account_screen.dart';
import 'package:progmob_magical_destroyers/screens/main/anggota/anggota_screen.dart';
import 'package:progmob_magical_destroyers/screens/main/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static late List<Widget> _widgetOptions;

  void changeBottomBarIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      HomeScreen(changeBottomBarIndexCallback: changeBottomBarIndex),
      AnggotaScreen(),
      AccountScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_outlined),
              label: 'Igniters',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Account',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: ColorPlanet.primary,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
