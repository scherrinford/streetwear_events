import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streetwear_events/data/models/event.dart';

import '../../../utilities/constants.dart';
import '../calendar/CalendarScreen.dart';
import 'EventTile.dart';

class EventList extends StatefulWidget{
  final Axis _axis;
  final double _marginRight;
  final double _marginTop;
  final DateTime startDate;
  final DateTime endDate;
  const EventList(this._axis, this._marginRight, this._marginTop, this.startDate, this.endDate);
  @override
  _EventListState createState() => _EventListState();
}



class _EventListState extends State<EventList>{

  int tileCount = 4;

  Widget _noFollowedEventsTile(BuildContext context){
    return Card(
        // margin: const EdgeInsets.only(right: 20),
          elevation: 5,
          color: themeLightColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
              alignment: AlignmentDirectional.center,
              width: 340,
              height: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: themeLightColor,
              ),
              child: Text("No events yet")
            // Icon(
            //   Icons.add,
            //   size: 100,
            //   color: Color(0x3EB4B2AB),
            // ),
          )

    );
  }

  Widget _noFollowedEvents(BuildContext context){
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: ListView(
            children: [
              _noFollowedEvents(context)
            ]
        )
    );
  }

  @override
  Widget build(BuildContext context) {

    // final events = Provider.of<List<Event>>(context);
    // tileCount = events.length;
    // print(tileCount);
    // if(tileCount > 0) {
    //   return ListView.builder(
    //       shrinkWrap: true,
    //       itemCount: tileCount,
    //       scrollDirection: widget._axis,
    //       itemBuilder: (BuildContext context, int index){
    //         return
    //           Container(
    //             margin: EdgeInsets.only(right: widget._marginRight, top: widget._marginTop),
    //             child: EventTile(event: events[index],),
    //           );
    //       }
    //     );
    // }else{
    //   return _noFollowedEvents(context);
    // }


    return StreamBuilder<List<Event>>(stream: Event.getListOfEventsByDateRange(widget.startDate, widget.endDate), builder: (context, snapshot) {
      if (snapshot.hasError){
        return _noFollowedEvents(context);
      }else if (snapshot.hasData){
        final _events = snapshot.data;
        if(_events!.length>0){
          return ListView(
            scrollDirection: widget._axis,
            children: _events.map(eventTile).toList(),
          );
        }else{
          return _noFollowedEvents(context);
        }

      }else{
        return Center(child: CircularProgressIndicator());
      }
    });

  }

  Widget eventTile(Event event){
    return Container(
              margin: EdgeInsets.only(right: widget._marginRight, top: widget._marginTop),
              child: EventTile(event: event),
            );
  }


  Stream<List<Event>> get events {
    return FirebaseFirestore.instance.collection('events').snapshots().map((snapshot) => snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList());
    // return eventsCollection.snapshots().map(_eventsListFromSnapshot);
  }
}
