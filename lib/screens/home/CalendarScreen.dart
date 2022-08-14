import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:streetwear_events/screens/home/CalendarWidget.dart';
import 'package:streetwear_events/screens/home/events/EventList.dart';
import 'package:streetwear_events/utilities/constants.dart';

class CalendarScreen extends StatefulWidget{
    @override
    _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<StatefulWidget>{

  String _selectedTabLabel = 'List View';

  void _switchTabLabel(int index) {
    setState(() {
      _selectedTabLabel = index==0?'Calendar View':'List View';
    });
  }

  Widget _calendarViewTab(BuildContext context){
    return CalendarWidget();
  }

  Widget _listViewTab(BuildContext context){
    return EventList(Axis.vertical, 0, 20);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("Events", style: titleTextStyle),
            bottom: TabBar(
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
}