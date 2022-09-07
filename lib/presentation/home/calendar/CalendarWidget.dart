import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:streetwear_events/data/models/event.dart' as EventFirebase;
import 'package:streetwear_events/utilities/constants.dart';

import '../events/DetailScreen.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<StatefulWidget> {
  DateTime _currentDate = new DateTime.now();
  DateTime _startDate = new DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime _endDate = new DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

  Stream<List<EventFirebase.Event>> getListOfEventsByDateRange(DateTime startDate, DateTime endDate){
    return FirebaseFirestore.instance.collection('events').where("date", isGreaterThanOrEqualTo: startDate, isLessThanOrEqualTo: endDate).snapshots().map((snapshot)
    => snapshot.docs.map((doc) => EventFirebase.Event.fromJson(doc.data())).toList());
  }


  static Event fromJson(Map<String,dynamic> data) => Event(
    title: data['name'],
    description: data['description'],
    location: data['location'],
    date: (data['date'] as Timestamp).toDate(),
  );

  void setDate(){
    _startDate = new DateTime(_currentDate.year, _currentDate.month, _currentDate.day);
    _endDate = new DateTime(_currentDate.year, _currentDate.month, _currentDate.day+1);
  }


  Widget _eventCard(EventFirebase.Event event){

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.album),
            title: Text(event.name),
            subtitle: Text(event.date.toString() + " " + event.location),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailScreen(event: event)));
            },
          ),
        ],
      ),
    );
  }



  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2019, 2, 10): [
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 1',
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Color(0xFFECB6B6),
            height: 5.0,
            width: 5.0,
          ),
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 2',
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 3',
        ),
      ],
    },
  );


  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: CalendarCarousel<Event>(
              onDayPressed: (DateTime date, List<Event> events) {
                this.setState(() => _currentDate = date);
                setDate();
              },
              onCalendarChanged: (DateTime date){
                this.setState(() => _startDate = date);
                this.setState(() => _endDate = DateTime(date.year, date.month+1, date.day-1));
              },
              weekendTextStyle: TextStyle(
                color: Colors.red,
              ),
              thisMonthDayBorderColor: Colors.grey,
              //      weekDays: null, /// for pass null when you do not want to render weekDays
              //      headerText: Container( /// Example for rendering custom header
              //        child: Text('Custom Header'),
              //      ),
              todayButtonColor: themeDarkColor,
              todayBorderColor: themeDarkColor,
              selectedDayButtonColor: Color(0xFFECB6B6),
              selectedDayBorderColor: Color(0xFFECB6B6),
              selectedDayTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              customDayBuilder: (
                  /// you can provide your own build function to make custom day containers
                  bool isSelectable,
                  int index,
                  bool isSelectedDay,
                  bool isToday,
                  bool isPrevMonthDay,
                  TextStyle textStyle,
                  bool isNextMonthDay,
                  bool isThisMonthDay,
                  DateTime day,
                  ) {
                /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
                /// This way you can build custom containers for specific days only, leaving rest as default.

                // Example: every 15th of month, we have a flight, we can place an icon in the container like that:

              },
              weekFormat: false,
              markedDatesMap: _markedDateMap,
              selectedDateTime: _currentDate,
              daysHaveCircularBorder: false,

              /// null for not rendering any border, true for circular border, false for rectangular border
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height / 5,
              child: StreamBuilder<List<EventFirebase.Event>>(stream: getListOfEventsByDateRange(_startDate, _endDate), builder: (context, snapshot) {
                  if (snapshot.hasError){
                    return Text("No events here");
                  }else if (snapshot.hasData){
                    final _events = snapshot.data;
                    return ListView(
                      children: _events!.map(_eventCard).toList(),
                    );
                  }else{
                    return Center(child: CircularProgressIndicator());
                  }
                }),

              )
        ]
    );
  }
}
