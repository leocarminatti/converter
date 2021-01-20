import 'package:currency_converter/screen/convert/convert_screen.dart';
import 'package:currency_converter/screen/currecies/currencies_screen.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    ConvertScreen(),
    CurrenciesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows),
            label: "Conversor",
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.monetization_on_outlined),
            label: "Moedas",
          ),
        ],
      ),
      body: _children[_currentIndex],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
