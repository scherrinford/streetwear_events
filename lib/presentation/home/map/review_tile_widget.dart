import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:streetwear_events/data/models/reviews.dart';

class ReviewTileWidget extends StatefulWidget {
  final Reviews review;

  const ReviewTileWidget({required this.review});

  @override
  _ReviewTileWidgetState createState() => _ReviewTileWidgetState();
}

class _ReviewTileWidgetState extends State<ReviewTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
            leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star),
                  Text(widget.review.rating.toString())
                ]),
            title: Text(widget.review.name),
            subtitle: Text(widget.review.description),
          ),
    );
  }
}
