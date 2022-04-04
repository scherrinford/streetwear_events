import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streetwear_events/models/AppUser.dart';

import 'package:streetwear_events/screens/authenticate/Authenticate.dart';
import 'package:streetwear_events/screens/home/UserProfileScreen.dart';
import 'package:streetwear_events/screens/home/events/AddNewEventsScreen.dart';
import 'package:streetwear_events/services/auth.dart';

class AppDrawer extends StatefulWidget {

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {

  Widget _logIn(){
    return ListTile(
      leading: Icon(Icons.login),
      title: Text('LogIn'),
      onTap: () {
        return Navigator.of(context).push(MaterialPageRoute(builder: (context) => Authenticate()));
      },
    );
  }

  Widget _logOut(AuthService auth){
    return ListTile(
      leading: Icon(Icons.login),
      title: Text('Log out'),
      onTap: () async{
        await auth.signOut();
      },
    );
  }

  Widget _profile(){
    return ListTile(
      leading: Icon(Icons.account_circle),
      title: Text('Profile'),
      onTap: () async {
        final currentUserId = Provider.of<AppUser>(context, listen: false);
        final moviesRef = FirebaseFirestore.instance.collection('users').withConverter<UserData>( ///TODO refactoring
          fromFirestore: (snapshot, _) => UserData.fromFirestore(snapshot.data()),
          toFirestore: (movie, _) => movie.toMap(),
        );
        print(currentUserId.uid);
        UserData currentUser = await moviesRef.doc(currentUserId.uid).get().then((snapshot) => snapshot.data());
        print(currentUser.name);
        return Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserProfileScreen(user: currentUser,))); //
      },
    );
  }

  Widget _settings(){
    return ListTile(
      leading: Icon(Icons.settings),
      title: Text('Settings'),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _addNewEvent(){
    return ListTile(
      leading: Icon(Icons.add),
      title: Text('Add New Event'),
      onTap: () {
        return Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNewEventsScreen()));
      },
    );
  }

  Widget _addOnlineStore(){
    return ListTile(
      leading: Icon(Icons.add),
      title: Text('Add Online Store'),
      onTap: () {
        //return Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNewEventsScreen()));
      },
    );
  }

  Widget _addStationaryStore(){
    return ListTile(
      leading: Icon(Icons.add),
      title: Text('Add Stationary Store'),
      onTap: () {
        //return Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNewEventsScreen()));
      },
    );
  }

  Widget _loggedUser(BuildContext context, AppUser user, AuthService auth){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF755540),
            ),
            child: Text(
              'User Name',
              style: TextStyle(
                color: Color(0xFFF0E4CB),
                fontSize: 24,
              ),
            ),
          ),
          _profile(),
          _settings(),
          _addNewEvent(),
          _addOnlineStore(),
          _addStationaryStore(),
          _logOut(auth)
        ],
      ),
    );
  }

  Widget _unloggedUser(BuildContext context){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF755540),
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

    final _user =Provider.of<AppUser>(context);
    final AuthService _auth = AuthService();

    print(_user);
    if(_user == null){
      return _unloggedUser(context);
    }else {
      return _loggedUser(context, _user, _auth);
    }
  }

}