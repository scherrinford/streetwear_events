

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceLocation{

  String id;
  String name;
  String city;
  String address;
  LatLng position;
  String description;
  MarkerId markerId;
  String type;

  PlaceLocation({
    required this.id,
    required this.name,
    required this.city,
    required this.address,
    required this.position,
    required this.description,
    required this.type,
    required this.markerId
  });

  Map<String, Object?> toJson() {
    return {
      'name' : name,
      'city' : city,
      'address' : address,
      'position' : position,
      'description' : description,
      'type' : type,
    };
  }

  static PlaceLocation fromJson(Map<String,dynamic> data) => PlaceLocation(
    id: data['id'],
    name: data['name'],
    city: data['city'],
    address: data['address'],
    description: data['description'],
    position: LatLng((data['position'] as GeoPoint).latitude, (data['position'] as GeoPoint).longitude),
    type: data['type'],
    markerId: MarkerId(data['markerId']),
  );

  static Stream<List<PlaceLocation>> getListOfLocations(){
    return FirebaseFirestore.instance.collection('locations').snapshots().map((snapshot)
    => snapshot.docs.map((doc) => PlaceLocation.fromJson(doc.data())).toList());
  }

  static Future saveLocation(String name, String description, String address, String type, String city, String markerId, LatLng position) async{
    DocumentReference docReference = FirebaseFirestore.instance.collection('locations').doc();
    return await docReference.set({
      'name' : name,
      'city' : city,
      'address' : address,
      'description' : description,
      'type': type,
      'position': GeoPoint(position.latitude, position.longitude),
      'id': docReference.id,
      'markerId': markerId
    });
  }


}