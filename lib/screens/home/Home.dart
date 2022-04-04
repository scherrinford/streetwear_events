import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:streetwear_events/screens/home/AllEventsScreen.dart';
import 'package:streetwear_events/screens/home/AppDrawer.dart';
import 'package:streetwear_events/screens/home/EventList.dart';
import 'package:streetwear_events/screens/home/EventTile.dart';
import 'package:streetwear_events/screens/home/UserProfileScreen.dart';
import 'package:streetwear_events/utilities/constants.dart';

import 'AppBar.dart';
import 'CalendarScreen.dart';
import 'events/AddNewEventsScreen.dart';

//GoogleMaps https://codelabs.developers.google.com/codelabs/google-maps-in-flutter#3

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  bool _isLogged = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _selectScreen(BuildContext context){
    if(_selectedIndex == 0) return _homeScreen(context);
    else if(_selectedIndex == 1) return CalendarScreen();
    else if(_selectedIndex == 2) return AllEventsList();
    else return Text(
      'Index 2: Website',
      style: optionStyle,
    );
  }

  Widget _homeScreen(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 40),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Events", style: titleTextStyle),
              TextButton(
                  onPressed: () {
                    return Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllEventsList()));
                  },
                  child: Text("Show more >"))
            ],
          )
        ),
        SizedBox(height: 40),
        Container(
            margin: const EdgeInsets.only(left: 20),
            width: double.maxFinite,
            height: 237,
            child: EventList(Axis.horizontal, 10, 0),
        ),
        SizedBox(height: 40),
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: Text("Followed profiles", style: smallTitleTextStyle),
        ),
        SizedBox(height: 20),
        Container(
          height: 70,
            margin: const EdgeInsets.only(left: 20),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 7,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index){
                  return
                    InkWell(
                      onTap: () {
                        return Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserProfileScreen()));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 20),
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: new DecorationImage(
                            image: backgroundImage,
                            fit: BoxFit.cover, //BoxFit.fitWidth,
                          ),
                        ),

                      ),
                    );
                }
            )
        ),
      ],
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
      floatingActionButton: new Visibility(
        visible: _isLogged,
        child: FloatingActionButton(
          onPressed: () {
            return Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNewEventsScreen()));
          },
          backgroundColor: Color(0xFF755540),
          child: const Icon(Icons.add),
        ),
      )
    );
  }

}


