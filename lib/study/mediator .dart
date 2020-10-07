import 'package:flutter/material.dart';
import 'package:lifestudy/study/class_screen.dart';
import 'package:lifestudy/study/study_screen.dart';

class MediatorScreen extends StatefulWidget {
  @override
  _MediatorScreenState createState() => _MediatorScreenState();
}

class _MediatorScreenState extends State<MediatorScreen> {
  int _selectedIndex = 0;
  List<Widget> _pageWidget = <Widget>[
    ClassScreen(),
    StudyScreen(),
  ];
  List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.class_),
      title: Text('Class'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.work),
      title: Text('Study'),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageWidget.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        items: _menuBar,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.blueGrey,
        onTap: _onItemTapped,
      ),
    );
  }
}