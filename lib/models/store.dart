import 'package:streetwear_events/models/place_location.dart';

class Store{

  String id;
  String uid;
  String name;
  String description;
  PlaceLocation placeLocation;

  Store({
    required this.id,
    required this.name,
    required this.uid,
    required this.placeLocation,
    required this.description
  });

}