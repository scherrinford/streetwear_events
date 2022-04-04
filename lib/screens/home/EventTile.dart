import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streetwear_events/models/AppUser.dart';
import 'package:streetwear_events/models/Event.dart';
import 'package:streetwear_events/screens/home/DetailScreen.dart';
import 'package:streetwear_events/utilities/constants.dart';

class EventTile extends StatefulWidget {
  final Event event;
  EventTile({this.event});

  @override
  _EventTileState createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {


  @override
  Widget build(BuildContext context) {
    //final event = Provider.of<Event>(context);
    return Container(
      //padding: EdgeInsets.only(top: 8.0),
      //margin: EdgeInsets.all(20.0),
      //margin: EdgeInsets.only(left: 30.0, right: 30.0),

      child: Card(
        elevation: 5,
        color: Color(0xFFF2EFE5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: () async {
            final moviesRef = FirebaseFirestore.instance.collection('users').withConverter<UserData>(
              fromFirestore: (snapshot, _) => UserData.fromFirestore(snapshot.data()),
              toFirestore: (movie, _) => movie.toMap(),
            );
            UserData userdata = await moviesRef.doc(widget.event.uid).get().then((snapshot) => snapshot.data());
            return Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailScreen(event: widget.event, user: userdata,)));
          },
          child: Container(
            width: 340,
            height: 240,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                  image: backgroundImage,
                  fit: BoxFit.cover
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                  tileColor: Color(0xFFF2EFE5),
                  title: Text(widget.event.name),
                  subtitle: Text(widget.event.location),
                  contentPadding: EdgeInsets.all(10),
                  trailing: IconButton(
                      icon: Icon(Icons.favorite),
                      onPressed: () {
                        ///TODO add logic
                        ///TODO create current user's favourites collection
                      },
                    ),
                ),
            ),
          ),
        ),
      ),
    );
  }

}