import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Event{
  final String uid;
  final String name;
  final String description;
  final String location;
  final String eventId;
  final DateTime date;
  //final String city;
  //final String photoUrl;


  Event(this.uid, this.name, this.description, this.location, this.eventId, this.date, );

  Map<String,dynamic> toMap(){
    return {
      'name' : name,
      'date' : date,
      'location' : location,
      'description' : description,
      'uid' : uid
    };
  }

  Event.fromSnapchot(DocumentSnapshot snapshot)
      : eventId = snapshot['eventId'],
        name = snapshot['name'],
        date = (snapshot['date'] as Timestamp)?.toDate(),
        location = snapshot['location'],
        description = snapshot['description'],
        uid = snapshot['uid'];

  Event.fromFirestore(Map<String, dynamic> firestore)
      : eventId = firestore['eventId'],
        name = firestore['name'],
        date = (firestore['date'] as Timestamp)?.toDate(),
        location = firestore['location'],
        description = firestore['description'],
        uid = firestore['uid'];
}