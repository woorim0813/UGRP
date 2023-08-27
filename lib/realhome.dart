// 홈화면의 bottom navigator 구현, 선택에 맞는 위젯으로 이동

import 'package:flutter/material.dart';
import 'home.dart';
import 'more.dart';
import 'add.dart';
import 'maps.dart';
import 'provider.dart';
import 'package:provider/provider.dart';

class Main extends StatefulWidget{
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _selectedIndex = 0;

  static List<Widget> pages = <Widget>[
    HomeScreen(),
    AddScreen(),
    initialmap(),
    MoreScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    context.read<UserProvider>().inupdate(userid);
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() { 
          _selectedIndex = index;}),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc_outlined),
            label: '나의 세션', 
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: '지도 보기'
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: '더보기'
            ),
        ],
        selectedItemColor: Color.fromARGB(200, 200,1, 80),
        unselectedFontSize: 14,
        selectedFontSize: 14,
        ),
    );
  }
}