import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:streetwear_events/models/Event.dart';
import 'package:streetwear_events/services/database.dart';

class UserData{

  final String uid;
  final String? name;
  final String? email;
  final String? phone;
  final String? photoUrl;
  final String? description;

  // List<Event>? savedEventsList;

  UserData({
    required this.uid,
    this.name,
    this.email,
    this.phone,
    // this.savedEventsList,
    this.photoUrl,
    this.description,
  });

  // String getUserId(){
  //   return uid;
  // }

  Map<String,dynamic> toMap(){
    return {
      'uid' : uid,
      'name' : name,
      'email' : email,
      'phone' : phone,
      'description' : description,
    };
  }

  Map<String, Object?> toJson() {
    return {
      'uid' : uid,
      'name' : name,
      'email' : email,
      'phone' : phone,
      'photoUrl' : photoUrl,
      'description' : description,
    };
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      uid: json['uid'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String,
      description: json['description'] as String,
      // savedEventsList: savedEventsList,
    );
  }

  static Stream<List<UserData>> getPartnersList(){
    return FirebaseFirestore.instance.collection('users').snapshots().map((snapshot)
    => snapshot.docs.map((doc) => UserData.fromJson(doc.data())).toList());
  }

  UserData.fromSnapchot(DocumentSnapshot snapshot, List<Event> savedEventsList)
      : uid = snapshot['uid'],
        name = snapshot['name'],
        email = snapshot['email'],
        phone = snapshot['phone'],
        photoUrl = snapshot['photoUrl'],
        description = snapshot['description'];
        // savedEventsList = savedEventsList;


  UserData.fromFirestore(Map<String, dynamic> firestore, List<Event> savedEventsList)
      : uid = firestore['uid'],
        name = firestore['name'],
        email = firestore['email'],
        phone = firestore['phone'],
        photoUrl = firestore['photoUrl'],
        description = firestore['description'];
        // savedEventsList = savedEventsList;

}

