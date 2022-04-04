import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppUser{
  final String uid;

  AppUser({this.uid});

  String getUserId(){
    return uid;
  }
}

class UserData{

  final String uid;
  final String name;
  final String email;
  final String phone;

  UserData({this.uid,this.name,this.email,this.phone});

  Map<String,dynamic> toMap(){
    return {
      'uid' : uid,
      'name' : name,
      'email' : email,
      'phone' : phone,
    };
  }

  UserData.fromSnapchot(DocumentSnapshot snapshot)
      : uid = snapshot['uid'],
        name = snapshot['name'],
        email = snapshot['email'],
        phone = snapshot['phone'];

  UserData.fromFirestore(Map<String, dynamic> firestore)
      : uid = firestore['uid'],
        name = firestore['name'],
        email = firestore['email'],
        phone = firestore['phone'];


}