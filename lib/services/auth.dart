import 'package:firebase_auth/firebase_auth.dart';
import 'package:streetwear_events/models/AppUser.dart';
import 'package:streetwear_events/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser us = null;
  //create user obj base on FirebaseUser
  AppUser _userFromFireBaseUser(User user){
    return user!=null ? us=AppUser(uid: user.uid) : us=null;
  }

  String get getUs{
    if(us!=null)
      return us.getUserId();
    return null;
  }

  //auth change user stream
  Stream<AppUser> get user{
    return _auth.authStateChanges().map(_userFromFireBaseUser);
  }

  Future signInAnon() async{
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFireBaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFireBaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password, String name, String phone) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      await DatabaseService(uid: user.uid).updateUserData(name,phone,email);

      return _userFromFireBaseUser(user);
    }catch(e){
      print('test');
      print(e.toString());
      return null;
    }
  }

  //Sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}