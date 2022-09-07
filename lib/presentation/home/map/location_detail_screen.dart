import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streetwear_events/data/models/place_location.dart';
import 'package:streetwear_events/data/models/user_data.dart';
import 'package:streetwear_events/data/models/event.dart';
import 'package:streetwear_events/data/services/database.dart';
import 'package:streetwear_events/presentation/home/map/add_review_screen.dart';
import 'package:streetwear_events/presentation/home/map/reviews_list_widget.dart';
import 'package:streetwear_events/utilities/constants.dart';

import '../../../data/models/reviews.dart';
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



  Widget _reviewsListWidget(String placeId){
    return StreamBuilder<List<Reviews>>(stream: Reviews.getListOfReviews(placeId), builder: (context, snapshot) {
      if(snapshot.hasData){
        double avg = avgOfRating(snapshot.data!);
        return Row(
              children: [
              Icon(Icons.star, size: 30,),
                Text(avg.toString(), style: TextStyle(fontSize: 25),),
              ],
          );
      }else{
        return Text("No data");
      }
    });
  }


  double avgOfRating(List<Reviews> reviews){
    double sum = 0;
    int length = reviews.length;
    reviews.forEach((review) {
      sum += review.rating;
    });
    return reviews.length>0 ? sum / reviews.length: 0;
  }

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
          height: MediaQuery.of(context).size.height,
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
                    Text(widget.placeLocation.name, style: titleTextStyle,  overflow: TextOverflow.clip,),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.black54),
                        SizedBox(width: 5),
                        Text(widget.placeLocation.address + ", " + widget.placeLocation.city, style: TextStyle(color: Colors.black54)),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _reviewsListWidget(widget.placeLocation.id),
                        ElevatedButton(
                            onPressed: () async {
                              Navigator.push( context, MaterialPageRoute(builder: (context) => AddReviewScreen(placeLocation: widget.placeLocation)),);
                            },
                            child: Text("Add Review") //TODO add follow button if not current user
                        ),
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


                    //_reviewsListWidget(widget.placeLocation.id),
                    ReviewsListWidget(placeId: widget.placeLocation.id)

                  ],
                )),

              ),
            ),
            //],
          ),
        ),
    );
  }
}