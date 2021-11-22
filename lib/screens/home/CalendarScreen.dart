

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return Text("It's calendar view here");
  }

  Widget _listViewTab(BuildContext context){
    return Text("It's calendar view here");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff755540),
            title: Text(_selectedTabLabel),
            bottom: TabBar(
              onTap: _switchTabLabel,
              indicatorColor: Color(0xff342013),
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.calendar_today),
                ),
                Tab(
                  icon: Icon(Icons.calendar_view_day),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Center(
                child: _calendarViewTab(context),
              ),
              Center(
                child: _listViewTab(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}