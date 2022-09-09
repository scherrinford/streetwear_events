import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:streetwear_events/data/models/event.dart';
import 'package:streetwear_events/data/services/database.dart';

class UserData{

  final String uid;
  final String? name;
  final String? email;
  final String? phone;
  final String? photoUrl;
  final String? description;
  final String? type;

  List<String>? savedEventsList;

  UserData({
    required this.uid,
    this.name,
    this.email,
    this.phone,
    this.savedEventsList,
    this.photoUrl,
    this.description,
    this.type,
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
      'type' : type,
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
      'type' : type,
    };
  }

  static UserData fromJson(Map<String, dynamic> json) => UserData(
      uid: json['uid'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      savedEventsList: List.from(json['savedEventsList']),
    );

  static Stream<List<UserData>> getPartnersList(){
    return FirebaseFirestore.instance.collection('users').where("type", isEqualTo: "pro").snapshots().map((snapshot)
    => snapshot.docs.map((doc) => UserData.fromJson(doc.data())).toList());
  }
  
  static Stream<UserData> getUserById(String uid){
    return FirebaseFirestore.instance.collection('users').where("uid", isEqualTo: uid).snapshots().map((snapshot)
    => snapshot.docs.map((doc) => UserData.fromJson(doc.data())).toList().elementAt(0));
  }

  static Future<void> addEventToFollowedList(String uid, String eventId) async {
    List<String> eventsIdsList = [];
    List<String> changeDataList = [];
    var userCollection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await userCollection.doc(uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      var array =  data['savedEventsList'];
      if(List<String>.from(array).length>0){
        eventsIdsList = List<String>.from(array);
      }
    }
    print(eventId);
    print(eventsIdsList);
    var collection = FirebaseFirestore.instance.collection('users');
    if(eventsIdsList.contains(eventId)){
      changeDataList.add(eventId);
      collection
          .doc(uid) //<-- Document ID
          .update({'savedEventsList': FieldValue.arrayRemove(changeDataList)}) // <-- Add data
          .then((_) => print('Updated'))
          .catchError((error) => print('Add failed: $error'));
    }else{
      changeDataList.add(eventId);
      collection
          .doc(uid) //<-- Document ID
          .update({'savedEventsList': FieldValue.arrayUnion(changeDataList)}) // <-- Add data
          .then((_) => print('Updated'))
          .catchError((error) => print('Add failed: $error'));
    }
    print(eventsIdsList);


  }

  UserData.fromSnapshot(DocumentSnapshot snapshot, List<String> savedEventsList)
      : uid = snapshot['uid'],
        name = snapshot['name'],
        email = snapshot['email'],
        phone = snapshot['phone'],
        photoUrl = snapshot['photoUrl'],
        description = snapshot['description'],
        type = snapshot['type'];
        // savedEventsList = savedEventsList;


  UserData.fromFirestore(Map<String, dynamic> firestore, List<String> savedEventsList)
      : uid = firestore['uid'],
        name = firestore['name'],
        email = firestore['email'],
        phone = firestore['phone'],
        photoUrl = firestore['photoUrl'],
        type = firestore['type'],
        description = firestore['description'];
        // savedEventsList = savedEventsList;

}

