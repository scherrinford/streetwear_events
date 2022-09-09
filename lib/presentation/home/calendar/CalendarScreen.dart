import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/servicemanagement/v1.dart';
import 'package:provider/provider.dart';
import 'package:streetwear_events/presentation/home/calendar/CalendarWidget.dart';
import 'package:streetwear_events/presentation/home/events/EventList.dart';
import 'package:streetwear_events/utilities/constants.dart';

import '../../../data/models/event.dart';
import '../../../data/models/user_data.dart';
import '../events/EventTile.dart';

class CalendarScreen extends StatefulWidget{
    @override
    _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<StatefulWidget>{

  String _selectedTabLabel = 'List View';

  late UserData _user;

  void _switchTabLabel(int index) {
    setState(() {
      _selectedTabLabel = index==0?'Calendar View':'List View';
    });
  }

  Widget _calendarViewTab(BuildContext context){
    return CalendarWidget();
  }

  Widget eventTile(Event event){
    return Container(
      margin: EdgeInsets.only(right: 0, top: 20),
      child: EventTile(event: event),
    );
  }

  Widget _listViewTab(BuildContext context){
    return StreamBuilder<List<Event>>(stream: Event.getListOfEventsByUsersFollowedList(_user.savedEventsList!), builder: (context, snapshot) {
      if (snapshot.hasError){
        print(snapshot.error);
        return Text("No event here");
      }else if (snapshot.hasData){
        print(snapshot.data?.length);
        final _events = snapshot.data;
        return ListView(
          scrollDirection: Axis.vertical,
          children: _events!.map(eventTile).toList(),
        );
      }else{
        return Center(child: CircularProgressIndicator());
      }
    });
      //EventList(Axis.vertical, 0, 20);
  }

  Widget _tabBarWidget(){
    return Container(
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar:  TabBar(
            onTap: _switchTabLabel,
            indicatorColor: Color(0xff342013),
            labelColor: Colors.black87,
            unselectedLabelColor: Colors.grey,
            tabs: <Widget>[
              Tab(
                text: "Calendar",
                //icon: Icon(Icons.calendar_today),
              ),
              Tab(
                text: "List",
                //icon: Icon(Icons.calendar_view_day),
              ),
            ],
          ),
          body: TabBarView(
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: _calendarViewTab(context),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: _listViewTab(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserData>(context);
    return StreamBuilder<UserData>(
        stream: UserData.getUserById(user.uid),
        builder: (context,snapshot) {
          print(snapshot.error);
          print(snapshot.data?.uid);
          if (snapshot.hasData) {
            _user = snapshot.data!;
            return _tabBarWidget();
          } else{
            return Center(child: CircularProgressIndicator());
          }
        }
    );


  }

}