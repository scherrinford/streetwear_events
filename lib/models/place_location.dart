

import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceLocation{

  String id;
  String name;
  String city;
  LatLng latLng;

  PlaceLocation({
    required this.id,
    required this.name,
    required this.city,
    required this.latLng
  });


}