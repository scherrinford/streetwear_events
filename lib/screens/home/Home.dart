
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:streetwear_events/screens/home/AppDrawer.dart';
import 'package:streetwear_events/screens/home/EventTile.dart';

import 'AppBar.dart';
import 'CalendarScreen.dart';

//GoogleMaps https://codelabs.developers.google.com/codelabs/google-maps-in-flutter#3

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _selectScreen(BuildContext context){
    if(_selectedIndex == 0) return ListView(
        children: <Widget>[
          EventTile(),
          EventTile(),
        ]
    );
    else if(_selectedIndex == 1) return CalendarScreen();
    else return Text(
      'Index 2: Website',
      style: optionStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _selectScreen(context),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.web),
            label: 'Website',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Color(0xFF755540),
        selectedItemColor: Color(0xFF755540),
        onTap: _onItemTapped,
      ),
      appBar: BaseAppBar(
        title: Text('title'),
        appBar: AppBar(),
        widgets: <Widget>[Icon(Icons.more_vert)],
      ),
      endDrawer: AppDrawer(),
    );
  }

}


