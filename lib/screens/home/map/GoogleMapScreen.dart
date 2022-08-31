import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:streetwear_events/models/place_location.dart';

import 'location_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  late GoogleMapController mapController;
  Location _location = Location();
  late CameraPosition _initialCameraPosition;
  List<Marker> allMarkers = [];

  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState(){
    super.initState();
      _initialCameraPosition = CameraPosition(target: LatLng(51.759029, 19.457432), zoom: 7);

  }

  Future<LocationData?> _currentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    Location location = new Location();

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    return await location.getLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    // mapController = controller;
    // _location.onLocationChanged.listen((l) {
    //   _initialCameraPosition = CameraPosition(target: LatLng(l.latitude!, l.longitude!),zoom: 12);
    //   mapController.animateCamera(
    //     CameraUpdate.newCameraPosition(
    //       CameraPosition(target: LatLng(l.latitude!, l.longitude!),zoom: 12),
    //     ),
    //   );
    // });
  }



  Widget _loadMap(){
    return StreamBuilder<List<PlaceLocation>>(
      stream: PlaceLocation.getListOfLocations(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text("Loading maps... Please wait");
        for (int i=0; i < snapshot.data!.length; i++){
            final marker = snapshot.data![i];
            allMarkers.add(new Marker(
              markerId: marker.markerId,
              position: new LatLng(marker.position.latitude, marker.position.longitude),
              infoWindow: InfoWindow(
                title: marker.name,
                snippet: marker.address,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => LocationDetailScreen(placeLocation: marker)));
              }
            ));
        }
        return GoogleMap(
            initialCameraPosition: _initialCameraPosition,
            mapType: MapType.normal,
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            markers:  allMarkers.toSet(),
        );
      }

    );
  }

  @override
  Widget build(BuildContext context) {

    return _loadMap();
    //   GoogleMap(
    //   initialCameraPosition: _initialCameraPosition,
    //   mapType: MapType.normal,
    //   onMapCreated: _onMapCreated,
    //   myLocationEnabled: true,
    //   markers: {
    //
    //     Marker(
    //       markerId: MarkerId("Vintage Point"),
    //       position: const LatLng(51.761291, 19.458075),
    //       infoWindow: InfoWindow(title: "Vintage Point", snippet: 'click for details'),
    //       onTap: () {
    //
    //       }
    //     ),
    //   }
    // );
  }
}


// SizedBox(
// height: 60,
// child: Card(
// child: new ListTile(
// leading: new Icon(Icons.search),
// title: new TextField(
// //controller: textController,
// decoration: new InputDecoration(
// hintText: 'Search', border: InputBorder.none),
// //onChanged: onSearchTextChanged,
// ),
// trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
// ///TODO add logic to search field
// //textController.clear();
// //onSearchTextChanged('');
// },),
// ),
// ),
// ),