import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streetwear_events/models/place_location.dart';
import 'package:streetwear_events/models/user_data.dart';
import 'package:streetwear_events/models/Event.dart';
import 'package:streetwear_events/services/database.dart';
import 'package:streetwear_events/utilities/constants.dart';

import '../AppBar.dart';
import '../Home.dart';

class LocationDetailScreen extends StatefulWidget{

  final PlaceLocation placeLocation;
  LocationDetailScreen({required this.placeLocation});
  @override
  _LocationDetailScreenState createState() => _LocationDetailScreenState();
}

///TODO ad wrap text to title and resize card

class _LocationDetailScreenState extends State<LocationDetailScreen> {

  late UserData user;




  @override
  Widget build(BuildContext context) {
    // user = getProductById(widget.event.uid) as UserData;

    return Dismissible(
      direction: DismissDirection.down,
      key: const Key('key'),
      onDismissed: (_) => Navigator.of(context).pop(),
      background: Container(color: Color(0x43000000).withOpacity(0.1)),
      child: Scaffold(
        // appBar: AppBar(
        //     backgroundColor: Color(0xFF755540),
        //     title: IconButton(
        //       icon: Icon(Icons.arrow_back_ios),
        //       onPressed: () {
        //         Navigator.pop(context);
        //       },
        //     ),
        //   ),
        //endDrawer: AppDrawer(),
        body: new Container(
          //height: 238,
          //constraints: BoxConstraints.tightFor(height: 221.0),
          decoration: BoxDecoration(
            color: themeLightColor,
            image: new DecorationImage(
              image: NetworkImage('https://hypebeast.com/image/2017/10/round-2-nyc-grand-opening-9.jpg'),
              fit: BoxFit.cover, //BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),
          child: Container(
            //shrinkWrap: true,
            child: //ren: [
            Card(
              elevation: 25,
              color: themeLightColor,
              margin: const EdgeInsets.only(top: 230),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Container(
                margin: EdgeInsets.all(30),
                child: ListView(
                  shrinkWrap: true,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(widget.placeLocation.name, style: titleTextStyle, softWrap: true, overflow: TextOverflow.fade,),//Text("Targi Jestem Vintage! #6", style: titleTextStyle),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.black54),
                        SizedBox(width: 5),
                        Text(widget.placeLocation.city + ", Warszawa", style: TextStyle(color: Colors.black54)),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text("Organizer", style: smallTitleTextStyle),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 20),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: new DecorationImage(
                              image: NetworkImage('https://hypebeast.com/image/2017/10/round-2-nyc-grand-opening-9.jpg'),
                              fit: BoxFit.cover, //BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Text("user.name as String", style: smallTitleTextStyle)
                      ],
                    ),
                    SizedBox(height: 20),
                    Text("Description", style: smallTitleTextStyle),
                    SizedBox(height: 10),
                    SizedBox(
                      //height: BoxWidthStyle.max,
                      child: Text(
                        widget.placeLocation.description,
                        style: TextStyle(color: Colors.black54),
                        softWrap: true,
                      ),
                    ),
                    // Positioned(
                    //   bottom: 20,
                    //   child: Row(
                    //     children: [
                    //
                    //
                    //     ],
                    //   ),
                    // ),
                    // ListTile(
                    //   title: Text('The Enchanted Nightingale'),
                    //   subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: <Widget>[
                    //     TextButton(
                    //       child: const Text('BUY TICKETS'),
                    //       onPressed: () { /* ... */ },
                    //     ),
                    //     const SizedBox(width: 8),
                    //     TextButton(
                    //       child: const Text('LISTEN'),
                    //       onPressed: () { /* ... */ },
                    //     ),
                    //     const SizedBox(width: 8),
                    //   ],
                    // ),

                  ],
                ),

              ),
            ),
            //],
          ),
        ),
      ),
    );
  }
}