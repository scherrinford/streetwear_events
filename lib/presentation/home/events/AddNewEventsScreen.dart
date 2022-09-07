
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:streetwear_events/data/models/user_data.dart';
import 'package:streetwear_events/presentation/home/Home.dart';
import 'package:streetwear_events/data/services/auth.dart';
import 'package:streetwear_events/data/services/database.dart';
import 'package:streetwear_events/utilities/constants.dart';
import 'package:google_place/google_place.dart';


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

  String _name = '';
  String _location = '';
  String _city = '';
  String _description = '';
  String _photoUrl = '';

  final _formKey = GlobalKey<FormState>();

  GooglePlace googlePlace = GooglePlace(kGoogleApiKey);
  final _searchFieldController = TextEditingController();
  List<AutocompletePrediction> predictions = [];
  DetailsResult? placeResult;

  late FocusNode focusNode;

  FilePickerResult? _filePickerResult;
  String _fileName = '';

  @override
  void initState() {
    dateInput.text = "";
    timeInput.text = "";
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    focusNode.dispose();
  }

  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
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
    TimeOfDay? pickedTime =  await showTimePicker(
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

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      // print(result.predictions!.first.description);
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    print(user);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeDarkColor,
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
                  validator: (val)=> val!.isEmpty? "Enter Name" : null,
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
                  controller: _searchFieldController,
                  focusNode: focusNode,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      //places api
                      autoCompleteSearch(value);
                    } else {
                      //clear out the results
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Find address',
                      suffixIcon: _searchFieldController.text.isNotEmpty
                          ? IconButton(
                        onPressed: () {
                          setState(() {
                            predictions = [];
                            _searchFieldController.clear();
                          });
                        },
                        icon: Icon(Icons.clear_outlined),
                      )
                          : null),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: predictions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.pin_drop,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          predictions[index].description.toString(),
                        ),
                        onTap: () async {
                          final placeId = predictions[index].placeId!;
                          final details = await googlePlace.details.get(placeId);
                          if (details != null &&
                              details.result != null &&
                              mounted) {
                            if (focusNode.hasFocus) {
                              setState(() {
                                placeResult = details.result;
                                _location = placeResult!.formattedAddress!;
                                // _name = placeResult!.name!;
                                // _lang = placeResult!.geometry!.location!.lng!;
                                // _lat = placeResult!.geometry!.location!.lat!;
                                // _placeId = placeId;
                                var localityPath = placeResult!.adrAddress?.split("<span class=\"locality\">");
                                _city =  localityPath![1].split("</span>")[0].trim();
                                _searchFieldController.text =
                                details.result!.name!;
                                predictions = [];
                              });
                            }
                          }
                        },
                      );
                    }),
                SizedBox(height: 20),
                TextFormField(
                  validator: (val)=> val!.isEmpty? "Enter Date" : null,
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
                  validator: (val)=> val!.isEmpty? "Enter Time" : null,
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
                  validator: (val)=> val!.isEmpty? "Enter Description" : null,
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
                OutlinedButton.icon(
                    onPressed: () async {
                      _filePickerResult = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['jpg', 'png'],
                      );
                      if (_filePickerResult != null) {
                        _photoUrl = _filePickerResult!.files.single.path!;
                        setState(() {
                          _fileName = _filePickerResult!.files.single.name;
                        });
                        print(_photoUrl);
                        print(_filePickerResult!.files.single.name);

                        // Upload file
                        // await FirebaseStorage.instance.ref('uploads/$_fileName').putData(_filePickerResult!.files.first.bytes!);

                      } else {
                        // User canceled the picker
                      }
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.black54,
                    ),
                    label: Text(
                      'SELECT IMAGE',
                      style: TextStyle(
                        color: Colors.black54,
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                ),
                if(_fileName!='')Text(_fileName),
                SizedBox(height: 20),
                RaisedButton(
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: themeDarkColor,
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(
                      color: themeLightColor,
                      letterSpacing: 1.5,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                  onPressed:() async {
                    if (_formKey.currentState!.validate()) {
                        _date = new DateTime(_date.year, _date.month, _date.day, _time.hour, _time.minute);
                        await DatabaseService(uid: user.uid).saveEvent(_name, _description, _location, _date);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );

                        // return Home();
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
