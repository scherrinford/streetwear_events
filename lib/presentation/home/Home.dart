import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streetwear_events/data/models/user_data.dart';
import 'package:streetwear_events/presentation/home/events/AllEventsScreen.dart';
import 'package:streetwear_events/presentation/home/AppDrawer.dart';
import 'package:streetwear_events/presentation/home/events/EventList.dart';
import 'package:streetwear_events/presentation/home/events/EventTile.dart';
import 'package:streetwear_events/presentation/home/map/google_map_screen.dart';
import 'package:streetwear_events/presentation/home/online_shop/OnlineStoresListScreen.dart';
import 'package:streetwear_events/presentation/home/user_profile/UserProfileScreen.dart';
import 'package:streetwear_events/utilities/constants.dart';

import 'AppBar.dart';
import 'calendar/CalendarScreen.dart';
import 'events/AddNewEventsScreen.dart';

//GoogleMaps https://codelabs.developers.google.com/codelabs/google-maps-in-flutter#3

class Home extends StatefulWidget{
  // final UserData currentUser;
  // Home({required this.currentUser})

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{

  final FirebaseAuth auth = FirebaseAuth.instance;

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
    else if(_selectedIndex == 2) return MapSample();
    else return OnlineStoresListScreen();
  }

  Widget _profilesList(BuildContext context){
    return StreamBuilder<List<UserData>>(stream: UserData.getPartnersList(), builder: (context, snapshot) {
      if (snapshot.hasError){
        return Text("No profiles here");
      }else if (snapshot.hasData){
        final _user = snapshot.data;
        return ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: _user!.map(_profilesTile).toList(),
        );
      }else{
        return Center(child: CircularProgressIndicator());
      }
    });
  }

  Widget _profilesTile(UserData user){
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserProfileScreen(user: user)));
      },
      child: Container(
          margin: const EdgeInsets.only(right: 20),
          width: 70,
          child: Column(
            children: [
              Container(

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
              SizedBox(height: 10),
              Text(user.name!, overflow: TextOverflow.clip, textAlign: TextAlign.center,),
            ]
          )
      )
    );
  }

  Widget _homeScreen(BuildContext context){
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Events", style: titleTextStyle),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllEventsList()));
                    },
                    child: Text("Show more >"))
              ],
            )
        ),
        SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.only(left: 20),
          width: double.maxFinite,
          height: 237,
          child: EventList(Axis.horizontal, 10, 0, DateTime.now(), DateTime(DateTime.now().year+2, DateTime.now().month, 0)),
        ),
        SizedBox(height: 40),
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: Text("Partners profiles", style: smallTitleTextStyle),
        ),
        SizedBox(height: 20),
        Container(
          height: 120,
          margin: const EdgeInsets.only(left: 20),
          child: _profilesList(context),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    print(user.uid);
    return  Scaffold(
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
          unselectedItemColor: themeDarkColor,
          selectedItemColor: themeDarkColor,
          onTap: _onItemTapped,
        ),
        appBar: BaseAppBar(
            title: Text("Streetwear Events"),
            appBar: AppBar(),
            widgets: <Widget>[Icon(Icons.more_vert)]
        ),
        endDrawer: AppDrawer(),
        floatingActionButton: new Visibility(
          visible: _isLogged,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddNewEventsScreen()),
              );
            },
            backgroundColor: themeDarkColor,
            child: const Icon(Icons.add),
          ),
        )
    );
  }

}


