import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:streetwear_events/screens/home/events/EventList.dart';
import 'package:streetwear_events/utilities/constants.dart';

import '../calendar/CalendarScreen.dart';

class AllEventsList extends StatefulWidget{
  @override
  _AllEventsListState createState() => _AllEventsListState();
}

class _AllEventsListState extends State<StatefulWidget>{
  String dropdownValue = 'select';

  Widget _dropDownListLocation(BuildContext context){ ///TODO figure out how to get location (city) list
    return DropdownButton<String>(
      hint: Text("Location"),
      value: dropdownValue,
      icon: const Icon(Icons.keyboard_arrow_down),
      //elevation: 16,
      //isExpanded: true,
      style: const TextStyle(
        color: Colors.grey,
      ),
      underline: SizedBox(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Warszawa', 'Kraków']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _dropDownListDate(BuildContext context){ ///TODO figure out how to get location (city) list
    return DropdownButton<String>(
      hint: Text("Date"),
      value: dropdownValue,
      icon: const Icon(Icons.keyboard_arrow_down),
      //elevation: 16,
      //isExpanded: true,
      style: const TextStyle(
        color: Colors.grey,
      ),
      underline: SizedBox(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Warszawa', 'Kraków']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _listViewTab(BuildContext context){
    return EventList(Axis.vertical, 0, 20);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Title'),
          backgroundColor: themeDarkColor,
        ),
        body: Container(
          child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                      child: Card(
                          child: new ListTile(
                            leading: new Icon(Icons.search),
                            title: new TextField(
                              //controller: textController,
                              decoration: new InputDecoration(
                                  hintText: 'Search', border: InputBorder.none),
                              //onChanged: onSearchTextChanged,
                            ),
                            trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                              ///TODO add logic to search field
                              //textController.clear();
                              //onSearchTextChanged('');
                            },),
                          ),
                        ),
                    ),
                    Card(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // _dropDownListDate(context),
                          // _dropDownListLocation(context),///TODO create _dropDownListDate
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(left: 30.0, right: 30.0),
                        child: _listViewTab(context),
                      ),
                    )
                  ],
            ),
          )
        )
    );
  }

}
