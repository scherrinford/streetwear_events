

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


}