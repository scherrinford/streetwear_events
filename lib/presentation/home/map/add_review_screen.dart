import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:streetwear_events/data/models/place_location.dart';
import 'package:streetwear_events/data/models/reviews.dart';
import 'package:streetwear_events/data/services/database.dart';

import '../../../data/models/user_data.dart';
import '../../../utilities/constants.dart';

class AddReviewScreen extends StatefulWidget {
  final PlaceLocation placeLocation;
  const AddReviewScreen({required this.placeLocation});

  @override
  _AddReviewScreenState createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {

  String _description = '';
  String _name = '';
  double ratingScore = 5;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeDarkColor,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 50.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                    'Add Review to ' + widget.placeLocation.name,
                    style: titleTextStyle,
                    overflow: TextOverflow.fade,
                ),
                SizedBox(height: 50),

                TextFormField(
                  validator: (val)=> val!.isEmpty? "Enter Name" : null,
                  onChanged: (val){

                    setState(()=>_name=val);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nick Name',
                  ),
                ),
                SizedBox(height: 20),
                RatingBar.builder(
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      ratingScore = rating;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (val)=> val!.isEmpty? "Enter Opinion" : null,
                  onChanged: (val){
                    setState(()=>_description=val);
                  },
                  keyboardType: TextInputType.multiline,
                  minLines: 4,
                  maxLines: 6,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Opinion',
                  ),
                ),
                SizedBox(height: 20),
                RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: themeDarkColor,
                    child: Text(
                      'SUBMIT',
                      style: TextStyle(
                        color: themeLightColor,
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    onPressed:() async {
                      if (_formKey.currentState!.validate()) {
                        await Reviews.saveReview(_name, _description, user.uid, widget.placeLocation.id, ratingScore);
                        // await DatabaseService(uid: user.uid).saveEvent(_name, _description, _location, );
                        Navigator.pop(context);
                        // return Home();
                      }
                    }
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
