import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streetwear_events/data/models/user_data.dart';
import 'package:streetwear_events/data/models/event.dart';
import 'package:streetwear_events/data/services/database.dart';
import 'package:streetwear_events/presentation/home/events/DetailScreen.dart';
import 'package:streetwear_events/utilities/constants.dart';
import 'package:intl/intl.dart';

class EventTile extends StatefulWidget {
  final Event event;
  EventTile({required this.event});

  @override
  _EventTileState createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {

  DatabaseService _databaseService = DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);

  Color iconColor = Colors.black26;

  bool iconState = false;



  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserData>(context);
    return Container(

      child: Card(
        elevation: 5,
        color: Color(0xFFF2EFE5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: () async {
            // final moviesRef = FirebaseFirestore.instance.collection('users').withConverter<UserData>(
            //   fromFirestore: (snapshot, _) => UserData.fromFirestore(snapshot.data() as Map<String,dynamic>),
            //   toFirestore: (movie, _) => movie.toMap(),
            // );
            //UserData userdata = _databaseService.getUserById(widget.event.uid) as UserData;// moviesRef.doc(widget.event.uid).get().then((snapshot) => snapshot.data() as Map<String,dynamic>);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailScreen(event: widget.event)));
          },
          child: Container(
            width: 340,
            height: 240,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                  image: backgroundImage,
                  fit: BoxFit.cover,
                  repeat: ImageRepeat.noRepeat
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: themeLightColor,
                child: ListTile(
                  tileColor: Color(0xFFF2EFE5),
                  title: Text(widget.event.name),
                  subtitle: Text(widget.event.location + '\n' + DateFormat.yMd().format(widget.event.date) + ' | ' + DateFormat.Hm().format(widget.event.date)),
                  // Column(
                  //
                  //     children: [
                  //       Text(widget.event.location + '\n' + widget.event.date.toString()),
                  //       Text(widget.event.date.toString())
                  //     ]
                  // ),
                  contentPadding: EdgeInsets.all(10),
                  trailing: IconButton(
                    icon: Icon(Icons.favorite, color: iconState? Colors.red : Colors.black26,),
                    onPressed: () async {
                      print(widget.event.id);
                      UserData.addEventToFollowedList(user.uid, widget.event.id);
                      setState(() {
                        iconState = !iconState;
                      });
                    },
                  ),
                ),
              )

            ),
          ),
        ),
      ),
    );
  }

}