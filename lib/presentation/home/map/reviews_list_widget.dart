
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:streetwear_events/data/models/reviews.dart';
import 'package:streetwear_events/presentation/home/map/review_tile_widget.dart';

import '../../../utilities/constants.dart';

class ReviewsListWidget extends StatefulWidget {
  final String placeId;

  const ReviewsListWidget({required this.placeId});

  @override
  ReviewsListWidgetState createState() => ReviewsListWidgetState();
}

class ReviewsListWidgetState extends State<ReviewsListWidget> {


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Reviews>>(stream: Reviews.getListOfReviews(widget.placeId), builder: (context, snapshot) {
      if (snapshot.hasError) {
        print(snapshot.error);
        return Text("No reviews here");
      } else if (snapshot.hasData) {
        final _reviws = snapshot.data;
        return ListView(
          shrinkWrap: true,
          children: _reviws!.map(_reviewsTile).toList(),
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    }

    );
  }



  Widget _reviewsTile(Reviews review) {
    return ReviewTileWidget(review: review,);
  }
}
