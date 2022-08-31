import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:streetwear_events/models/place_location.dart';
import 'package:streetwear_events/models/user_data.dart';
import 'package:streetwear_events/screens/home/events/DetailScreen.dart';
import 'package:streetwear_events/screens/home/Home.dart';
import 'package:streetwear_events/services/auth.dart';
import 'package:streetwear_events/services/database.dart';
import 'package:streetwear_events/utilities/constants.dart';
// import 'package:google_maps_place_picker/google_maps_place_picker.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_place/google_place.dart';

class AddNewLocationScreen extends StatefulWidget{
  @override
  _AddNewLocationScreenState createState() => _AddNewLocationScreenState();

}

///TODO add api from facebook option for adding new event
///TODO add photo attachment field to form

class _AddNewLocationScreenState extends State<StatefulWidget>{


  // late PickResult selectedPlace;

  String _type = 'Store';
  String _name = '';
  String _location = '';
  String _city = '';
  String _description = '';
  String _placeId = '';
  late double _lat;
  late double _lang;

  final _formKey = GlobalKey<FormState>();


  GoogleMapsPlaces googleMapsPlaces = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  GooglePlace googlePlace = GooglePlace(kGoogleApiKey);

  final _searchFieldController = TextEditingController();

  List<AutocompletePrediction> predictions = [];
  DetailsResult? placeResult;

  late FocusNode focusNode;




  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    focusNode.dispose();
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

  // Future<Null> displayPrediction(Prediction p) async {
  //   if (p != null) {
  //     GoogleMapsPlaces _places = GoogleMapsPlaces(
  //       apiKey: kGoogleApiKey,
  //       apiHeaders: await GoogleApiHeaders().getHeaders(),
  //     );
  //     PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId!);
  //     final lat = detail.result.geometry!.location.lat;
  //     final lng = detail.result.geometry!.location.lng;
  //
  //     print(lat);
  //     print(lng);
  //   }
  // }


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
                    'Add New Location',
                    style: titleTextStyle
                ),
                SizedBox(height: 50),
                // RaisedButton(
                //     onPressed: () async {
                //       // show input autocomplete with selected mode
                //       // then get the Prediction selected
                //       Prediction? p = await PlacesAutocomplete.show(
                //           context: context,
                //           apiKey: kGoogleApiKey,
                //           strictbounds: false,
                //           components: [new Component(Component.country, "pl")],
                //           types: ["locality", "political", "geocode", "shop"],
                //           startText: _city == null || _city == "" ? "" : _city,
                //           decoration: InputDecoration(
                //           hintText: 'Search',
                //       ),);
                //       displayPrediction(p!);
                //     },
                //     child: Text('Find address'),
                //
                // ),
                SizedBox(height: 30),
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
                                _name = placeResult!.name!;
                                _lang = placeResult!.geometry!.location!.lng!;
                                _lat = placeResult!.geometry!.location!.lat!;
                                _placeId = placeId;
                                print(placeResult!.adrAddress);
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
                        await PlaceLocation.saveLocation(_name, _description, _location, _type, _city, _placeId, LatLng(_lat, _lang));
                        // await DatabaseService(uid: user.uid).saveEvent(_name, _description, _location, );
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
