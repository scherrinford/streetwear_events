import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:streetwear_events/models/user_data.dart';
import 'package:streetwear_events/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  late UserData? us = null;
  // create user obj base on FirebaseUser
  UserData? _userFromFireBaseUser(UserData user){
    // ignore: unnecessary_null_comparison
    return user!=null ? us=user : us=null;
  }


  //auth change user stream
  Stream<UserData> get user{
    return _auth.authStateChanges().map(_userFromFireBaseUser as UserData Function(User?));
    // return _auth.authStateChanges().map((firebaseUser) {
    //   final user = firebaseUser == null ? UserData() : us=UserData();
    //   _cache.write(key: userCacheKey, value: user);
    //   return user;
    // });
  }



  Future signInAnon() async{
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      //return _userFromFireBaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password, String name, String phone) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      await DatabaseService(uid: user!.uid).updateUserData(name,phone,email);


      //return _userFromFireBaseUser(user);
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
