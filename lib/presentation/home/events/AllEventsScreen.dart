import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:streetwear_events/presentation/home/events/EventList.dart';
import 'package:streetwear_events/utilities/constants.dart';
import 'package:intl/intl.dart';
import '../../../data/models/event.dart';
import '../calendar/CalendarScreen.dart';

class AllEventsList extends StatefulWidget{
  @override
  _AllEventsListState createState() => _AllEventsListState();
}

class _AllEventsListState extends State<StatefulWidget>{
  String dropdownValue = '';

  List<String> cityList = [];

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime(DateTime.now().year+2, DateTime.now().month, 0);
  String selectedStartDate = '';
  String selectedEndDate = '';
  TextEditingController dateInput = TextEditingController();

  Future<void> _setCityList() async {
    cityList = await Event.getCityList();
    dropdownValue = cityList.first;
  }

  Widget _dropDownListLocation(BuildContext context){
    return Container(
        alignment: Alignment.center,
        height: 60,
        // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      border: Border.all(color: Colors.black12, width: 1)
    ),

    // dropdown below..
    child: DropdownButton<String>(
            value: dropdownValue,
            icon: Padding( //Icon at tail, arrow bottom is default icon
                padding: EdgeInsets.only(left:30),
                child: Icon(Icons.arrow_drop_down),
            ),
            elevation: 16,
            underline: SizedBox(),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
            },
            items: cityList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
    );
  }

  void _selectDate() async {
    final DateTimeRange? newDate = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year-1, 1, 1),
      lastDate: DateTime(DateTime.now().year+2, DateTime.now().month, 1),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      String formattedStartDate = DateFormat('dd-MM-yyyy').format(newDate.start);
      String formattedEndDate = DateFormat('dd-MM-yyyy').format(newDate.end);
      setState(() {
        _startDate = newDate.start;
        _endDate = newDate.end;
        selectedStartDate = formattedStartDate;
        selectedEndDate = formattedEndDate;
        dateInput.text = formattedStartDate + ' - ' + formattedEndDate;
      });
    }
  }

  Widget _selectDataButton(BuildContext context){
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black12, width: 1)
        ),

        // dropdown below..
        child: Padding(
        padding: EdgeInsets.only(left:10, right:10),
    child: TextFormField(
      controller: dateInput,
      readOnly: true,
      onTap: _selectDate,
      decoration: InputDecoration(
          labelText: 'Filter by date',
          suffixIcon: dateInput.text.isNotEmpty
              ? IconButton(
            onPressed: () {
              setState(() {
                _startDate = DateTime.now();
                _endDate = DateTime(DateTime.now().year+2, DateTime.now().month, 0);
                dateInput.clear();
              });
            },
            icon: Icon(Icons.clear_outlined),
          )
              : null),
    )));
  }

  Widget _listViewTab(BuildContext context){
    return EventList(Axis.vertical, 0, 20, _startDate, _endDate);
  }

  @override
  Widget build(BuildContext context) {
    _setCityList();
    return Scaffold(
        appBar: AppBar(
          title: Text('Explore Event'),
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding:  EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(child: _selectDataButton(context)),
                          SizedBox(width: 5,),
                          Expanded(child: _dropDownListLocation(context),),
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
