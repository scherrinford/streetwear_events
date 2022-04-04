import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:streetwear_events/models/AppUser.dart';
import 'package:streetwear_events/services/auth.dart';
import 'package:streetwear_events/services/database.dart';
import 'package:streetwear_events/utilities/constants.dart';

class AddNewEventsScreen extends StatefulWidget{
  @override
  _AddNewEventsScreenState createState() => _AddNewEventsScreenState();
  
}

///TODO add api from facebook option for adding new event
///TODO add photo attachment field to form

class _AddNewEventsScreenState extends State<StatefulWidget>{

  TextEditingController dateInput = TextEditingController();
  TextEditingController timeInput = TextEditingController();

  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

  String _name;
  String _location;
  String _city;
  String _description;

  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    dateInput.text = "";
    timeInput.text = "";
    super.initState();
  }

  void _selectDate() async {
    final DateTime newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(DateTime.now().year-1, 1, 1),
      lastDate: DateTime(DateTime.now().year+2, DateTime.now().month, 1),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
      setState(() {
        _date = newDate;
        dateInput.text = formattedDate;
      });
    }
  }

  void _selectTime() async {
    TimeOfDay pickedTime =  await showTimePicker(
      initialTime: _time,
      context: context,
    );

    if(pickedTime != null ) {
      DateTime parsedTime = DateFormat.jm().parse(
          pickedTime.format(context).toString());
      String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);

      setState(() {
        _time = pickedTime;
        timeInput.text = formattedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    print(user);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF755540),
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
                  'Add New Event',
                  style: titleTextStyle
                ),
                SizedBox(height: 50),
                TextFormField(
                  validator: (val)=> val.isEmpty? "Enter Name" : null,
                  onChanged: (val){
                    setState(()=>_name=val);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Event Name',
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (val)=> val.isEmpty? "Enter Place" : null,
                  onChanged: (val){
                    setState(()=>_location=val);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Place',
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (val)=> val.isEmpty? "Enter City" : null,
                  onChanged: (val){
                    setState(()=>_city=val);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'City',
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (val)=> val.isEmpty? "Enter Date" : null,
                  controller: dateInput,
                  readOnly: true,
                  onTap: _selectDate,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date',
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (val)=> val.isEmpty? "Enter Time" : null,
                  controller: timeInput,
                  readOnly: true,
                  onTap: _selectTime,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Time',
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (val)=> val.isEmpty? "Enter Description" : null,
                  onChanged: (val){
                    setState(()=>_description=val);
                  },
                  keyboardType: TextInputType.multiline,
                  minLines: 4,
                  maxLines: 6,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                ),
                SizedBox(height: 20),

                SizedBox(height: 20),
                RaisedButton(
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Color(0xFF755540),
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(
                      color: Color(0xFFFDFDFD),
                      letterSpacing: 1.5,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                  onPressed:() async {
                    if (_formKey.currentState.validate()) {
                        if(user != null){
                          _date = new DateTime(_date.year, _date.month, _date.day, _time.hour, _time.minute);
                          await DatabaseService(uid: user.uid).saveEvent(_name, _description, _location, _date);
                        }
                    }
                  }

                  // async{
                  //   if(_formKey.currentState.validate())
                  //   {
                  //     print(email);
                  //     print(password);
                  //     setState(()=> loading = true);
                  //     dynamic result = await _auth.registerwithEmailandPassword(email, password, name, phone);
                  //      if(result == null)
                  //      {
                  //        setState((){
                  //          error='Data user already exist or you pass wrong email';
                  //          loading = false;
                  //        });
                  //      }
                  //   }
                  // } ,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
