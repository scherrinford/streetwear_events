import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:streetwear_events/data/models/user_data.dart';

class Reviews{

  final double rating;
  final String id;
  final String name;
  final String uid;
  final String placeId;
  final String description;

  Reviews({
    required this.rating,
    required this.id,
    required this.name,
    required this.uid,
    required this.placeId,
    required this.description
  });

  static Reviews fromJson(Map<String,dynamic> data) => Reviews(
    rating: data['rating'],
    name: data['name'],
    description: data['description'],
    placeId: data['placeId'],
    uid: data['uid'],
    id: data['id'],
  );

  Map<String, Object?> toJson() {
    return {
      'uid' : uid,
      'name' : name,
      'id' : id,
      'rating' : rating,
      'placeId' : placeId,
      'description' : description,
    };
  }

  static Future saveReview(String name, String description, String uid, String placeId, double rating) async{
    DocumentReference docReference = FirebaseFirestore.instance.collection('reviews').doc();
    return await docReference.set({
      'uid' : uid,
      'name' : name,
      'id' : docReference.id,
      'rating' : rating,
      'placeId' : placeId,
      'description' : description,
    });
  }

  static getListOfReviews(String placeId) {
    return FirebaseFirestore.instance.collection('reviews').where("placeId", isEqualTo: placeId).snapshots().map((snapshot)
    => snapshot.docs.map((doc) => Reviews.fromJson(doc.data())).toList());
  }

}