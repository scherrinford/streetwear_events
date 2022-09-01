import 'package:streetwear_events/models/place_location.dart';

class Store{

  String id;
  String uid;
  String name;
  String description;
  String type;
  String url;
  String photoUrl;
  // PlaceLocation placeLocation;

  Store({
    required this.id,
    required this.name,
    required this.uid,
    required this.url,
    required this.photoUrl,
    required this.type,
    // required this.placeLocation,
    required this.description
  });

  static Store fromJson(Map<String, dynamic> data) => Store(
    id: data['id'],
    name: data['name'],
    description: data['description'],
    type: data['type'],
    uid: data['uid'],
    url: data['url'],
    photoUrl: data['photoUrl'],
  );

}