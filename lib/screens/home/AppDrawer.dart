import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streetwear_events/models/user_data.dart';

import 'package:streetwear_events/screens/authenticate/authenticate_wrapper.dart';
import 'package:streetwear_events/screens/home/user_profile/UserProfileScreen.dart';
import 'package:streetwear_events/screens/home/events/AddNewEventsScreen.dart';
import 'package:streetwear_events/services/auth.dart';

import '../../services/database.dart';
import '../../utilities/constants.dart';
import 'map/add_new_location_screen.dart';

class AppDrawer extends StatefulWidget {
  // final UserData user;
  // AppDrawer({required this.user});

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {

  final AuthService _auth = AuthService();
  late UserData _userData;

  Widget _logIn() {
    return ListTile(
      leading: Icon(Icons.login),
      title: Text('LogIn'),
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AuthenticateWrapper()));
      },
    );
  }

  Widget _logOut(AuthService auth) {
    return ListTile(
      leading: Icon(Icons.login),
      title: Text('Log out'),
      onTap: () async {
        await auth.signOut();
      },
    );
  }

  Widget _profile() {
    return ListTile(
      leading: Icon(Icons.account_circle),
      title: Text('Profile'),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserProfileScreen(user: _userData)));
      },
    );
  }

  Widget _settings() {
    return ListTile(
      leading: Icon(Icons.settings),
      title: Text('Settings'),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _addNewEvent() {
    return ListTile(
      leading: Icon(Icons.add),
      title: Text('Add New Event'),
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddNewEventsScreen()));
      },
    );
  }

  Widget _addOnlineStore() {
    return ListTile(
      leading: Icon(Icons.add),
      title: Text('Add Online Store'),
      onTap: () {
        //return Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNewEventsScreen()));
      },
    );
  }

  Widget _addStationaryStore() {
    return ListTile(
      leading: Icon(Icons.add),
      title: Text('Add Stationary Store'),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNewLocationScreen()));
      },
    );
  }

  _getCurrentUserData() async {
    // final currentUserId = Provider.of<UserData>(context, listen: false);
    // final moviesRef = FirebaseFirestore.instance.collection('users').withConverter<UserData>( ///TODO refactoring
    //   fromFirestore: (snapshot, _) => UserData.fromFirestore(snapshot.data()),
    //   toFirestore: (movie, _) => movie.toMap(),
    // );
    // print(currentUserId.uid);
    // UserData currentUser = _databaseService.getUserById(user?.uid)
    //     as UserData; //await moviesRef.doc(currentUserId.uid).get().then((snapshot) => snapshot.data());
    // print(currentUser.name);
  }

  Widget _loggedUser() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: themeDarkColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _userData.name!,
                  style: TextStyle(
                    color: themeLightColor,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 10),
                // Text(
                //   _userData.email!,
                //   style: TextStyle(
                //     color: themeLightColor,
                //     fontSize: 12,
                //   ),
                // ),
              ]
            ),
          ),
          _profile(),
          _settings(),
          _addNewEvent(),
          _addOnlineStore(),
          _addStationaryStore(),
          _logOut(_auth)
        ],
      ),
    );
  }

  Widget _unloggedUser(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: themeDarkColor,
            ),
            child: Text(
              ' ',
              style: TextStyle(
                color: Color(0xFFF0E4CB),
                fontSize: 24,
              ),
            ),
          ),
          _logIn()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // https://firebase.flutter.dev/docs/auth/usage/
    var user = Provider.of<UserData>(context);
    final AuthService _auth = AuthService();

    return StreamBuilder<UserData>(
        stream: UserData.getCurrentUser(user.uid),
        builder: (context,snapshot) {
          print(snapshot.error);
          print(snapshot.data?.uid);
          if (snapshot.hasData) {
            _userData = snapshot.data!;
            return _loggedUser();
          } else{
            return _unloggedUser(context);
          }
        }
    );


    // print(_auth.us.name);
    // if (user == null) {
    //   return _unloggedUser(context);
    // } else {
    //   return _loggedUser(context, _auth);
    // }
  }
}
