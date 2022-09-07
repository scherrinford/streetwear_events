import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:streetwear_events/data/models/reviews.dart';
import 'package:streetwear_events/data/models/user_data.dart';
import 'package:streetwear_events/data/models/event.dart';

class DatabaseService{

    final String? uid;
    DatabaseService( { required this.uid });

    final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
    final CollectionReference eventsCollection = FirebaseFirestore.instance.collection('events');
    final CollectionReference locationsCollection = FirebaseFirestore.instance.collection('locations');
    final CollectionReference savedEventsCollection = FirebaseFirestore.instance.collection('locations');

    List<Event>? get savedEventsList => null;


    //final CollectionReference savedEventCollection = FirebaseFirestore.instance.collection('savedEvent');
    //final CollectionReference Collection = FirebaseFirestore.instance.collection('users');

    Future<void> saveProduct(Event event){
        return eventsCollection.doc(event.id).set(event.toMap());
    }

    Future saveEvent(String name, String description, String location, DateTime date) async{
        return await eventsCollection.doc().set({
            'name' : name,
            'date' : date,
            'location' : location,
            'description' : description,
            'uid' : uid
        });
    }



    Stream<List<Event>> get events {
        return FirebaseFirestore.instance.collection('events').snapshots().map((snapshot) => snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList());
        // return eventsCollection.snapshots().map(_eventsListFromSnapshot);
    }

    List<Event> _eventsListFromSnapshot(QuerySnapshot snapshot){
        return snapshot.docs.map((doc){
            return Event.fromJson(doc.data()as Map<String, dynamic>);
        }).toList();
    }

    Stream<List<Event>> getProducts() {
        return eventsCollection.snapshots().map((snapshot) => snapshot.docs.map((document) => Event.fromSnapchot(document)).toList());
    }

    List<UserData> _userListFromSnapshot(QuerySnapshot snapshot){
        return snapshot.docs.map((doc){
            return UserData.fromJson(doc.data() as Map<String,dynamic>);
        }).toList();
    }

    Stream<List<UserData>> getUsersList() {
        return usersCollection.snapshots().map((snapshot) => snapshot.docs.map((document) => UserData.fromFirestore(document.data() as Map<String,dynamic>, savedEventsList!)).toList());
    }

    Future<void> removeProduct(String productId){
        return eventsCollection.doc(productId).delete();
    }

    Future updateUserData(String name, String phone, String email) async{
        return await usersCollection.doc(uid).set({
            'uid' : uid,
            'name' : name,
            'phone' : phone,
            'email' : email,
        });
    }

    Stream<Event> getProductById(String id){
        final Query myproduct = eventsCollection.where("productId",isEqualTo: id);
        return myproduct.snapshots().map((snapshot) => snapshot.docs.map((document) => Event.fromSnapchot(document)).toList().elementAt(0)) ;
    }

    Stream<UserData> getUserById(String? id){
        final Query user = usersCollection.where("uid",isEqualTo: id);
        return user.snapshots().map((snapshot) => snapshot.docs.map((document) => UserData.fromSnapchot(document, savedEventsList!)).toList().elementAt(0)) ;
    }

    Stream<Event> getSavedEventsList(String id){
        final Query myproduct = eventsCollection.where("productId",isEqualTo: id);
        return myproduct.snapshots().map((snapshot) => snapshot.docs.map((document) => Event.fromSnapchot(document)).toList().elementAt(0)) ;

        // final nameList= FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(userId)
        //     .collection('namesList')
        //     .where('name', isNotEqualTo: '')
        //     .snapshots();
    }

    Stream<List<Event>> getListOfEventsByDateRange(DateTime startDate, DateTime endDate){
        final Query dateRangeQuery = FirebaseFirestore.instance.collection('events').where("date", isGreaterThanOrEqualTo: startDate, isLessThanOrEqualTo: endDate);
        return FirebaseFirestore.instance.collection('events').where("date", isGreaterThanOrEqualTo: startDate, isLessThanOrEqualTo: endDate).snapshots().map((snapshot) => snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList());
    }

}