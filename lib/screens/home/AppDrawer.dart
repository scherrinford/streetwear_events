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

class AppDrawer extends StatefulWidget {
  // final UserData user;
  // AppDrawer({required this.user});

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  DatabaseService _databaseService =
      DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);
  late UserData user;

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
      onTap: () async {
        // final currentUserId = Provider.of<UserData>(context, listen: false);
        // final moviesRef = FirebaseFirestore.instance.collection('users').withConverter<UserData>( ///TODO refactoring
        //   fromFirestore: (snapshot, _) => UserData.fromFirestore(snapshot.data()),
        //   toFirestore: (movie, _) => movie.toMap(),
        // );
        // print(currentUserId.uid);
        // UserData currentUser = _databaseService.getUserById(user?.uid)
        //     as UserData; //moviesRef.doc(currentUserId.uid).get().then((snapshot) => snapshot.data() );
        // print(currentUser.name);
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => UserProfileScreen(
        //           user: currentUser,
        //         ))); //
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
        //return Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNewEventsScreen()));
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

  Widget _loggedUser(BuildContext context, AuthService _auth) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: themeDarkColor,
            ),
            child: Text(
              "user.name",
              style: TextStyle(
                color: themeLightColor,
                fontSize: 24,
              ),
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
    user = Provider.of<UserData>(context);
    print(user.name);
    final AuthService _auth = AuthService();

    // final FirebaseAuth auth = FirebaseAuth.instance;
    // final User? user = auth.currentUser;

    // print(_auth.us.name);
    if (user == null) {
      return _unloggedUser(context);
    } else {
      return _loggedUser(context, _auth);
    }
  }
}
