import 'package:flutter/material.dart';
import 'package:news_app/Screen/bn_screens/images_screen.dart';
import 'package:news_app/Screen/bn_screens/profile_screen.dart';
import 'package:news_app/Screen/bn_screens/settings_screen.dart';
import 'package:news_app/models/bn_screen.dart';

import 'bn_screens/news_scrren.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<BnScreen> _screen = <BnScreen>[
    const BnScreen(title: 'News', widget: NewsScreen()),
    const BnScreen(title: 'Images', widget: ImagesScreen()),
    const BnScreen(title: 'Profiles', widget: ProfileScreen()),
    const BnScreen(title: 'Settings', widget: SettingsScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            _screen[_currentIndex].title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (int currentIndex) {
          setState(() {
            _currentIndex = currentIndex;
          });
        },
        // selectedIconTheme: const IconThemeData(color: Colors.purple),
        // selectedLabelStyle: const TextStyle(color: Colors.black),
        selectedItemColor: Colors.blue.shade900,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'News'),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Images'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Person'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      body: _screen[_currentIndex].widget,
    );
  }
}
