import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:streetwear_events/data/models/user_data.dart';

class Event{
  final String id;
  final String name;
  final String description;
  final String location;
  final String uid;
  final DateTime date;
  final String city;
  //final String photoUrl;


  Event({
    this.id = '',
    required this.name,
    required this.description,
    required this.location,
    required this.uid,
    required this.date,
    required this.city,
  });

  Map<String,dynamic> toMap(){
    return {
      'name' : name,
      'date' : date,
      'location' : location,
      'description' : description,
      'uid' : uid
    };
  }

  Stream<List<Event>> get events {
    return FirebaseFirestore.instance.collection('events').snapshots().map((snapshot) => snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList());
    // return eventsCollection.snapshots().map(_eventsListFromSnapshot);
  }

  static Stream<List<Event>> getListOfEventsByDateRange(DateTime startDate, DateTime endDate){
    return FirebaseFirestore.instance.collection('events').where("date", isGreaterThanOrEqualTo: startDate, isLessThanOrEqualTo: endDate).snapshots().map((snapshot)
    => snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList());
  }

  static Stream<List<Event>> getListOfEventsByUser(String uid){
    return FirebaseFirestore.instance.collection('events').where("uid", isEqualTo: uid).orderBy("date", descending: true).snapshots().map((snapshot)
    => snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList());
  }

  static Stream<List<Event>> getListOfEventsByUsersFollowedList(List<String> savedEventsList){
    return FirebaseFirestore.instance.collection('events').where("id", whereIn: savedEventsList).snapshots().map((snapshot)
    => snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList());
  }

  static Future<List<String>> getCityList() async {
    var eventsCollection = FirebaseFirestore.instance.collection('events');
    var docSnapshot = await eventsCollection.get();
    List<String> cityList = ['All'];
    if (docSnapshot.docs.isNotEmpty) {
      for(int i = 0; i < docSnapshot.docs.length; i++){
        var event = docSnapshot.docs.elementAt(i);
        Map<String, dynamic> data = event.data();
        var city =  data['city'];
        if(!cityList.contains(city)){
          cityList.add(city);
        }
      }
    }
    return cityList;
  }

  static Event fromJson(Map<String,dynamic> data) => Event(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      location: data['location'],
      uid: data['uid'],
      date: (data['date'] as Timestamp).toDate(),
      city: data['city'],

  );

  factory Event.fromFirestore( DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options, ){
    final data = snapshot.data();
    return Event(
        uid: data!['uid'],
        name: data['name'],
        description: data['description'],
        location: data['location'],
        id: data['id'],
        date: data['date'],
        city: ''
    );
  }

  Event.fromSnapchot(DocumentSnapshot snapshot)
      : id = snapshot['id'],
        name = snapshot['name'],
        date = (snapshot['date'] as Timestamp).toDate(),
        location = snapshot['location'],
        description = snapshot['description'],
        uid = snapshot['uid'],
        city = snapshot['city'];


  // Event.fromFirestore(Map<String, dynamic> firestore)
  //     : eventId = firestore['eventId'],
  //       name = firestore['name'],
  //       date = (firestore['date'] as Timestamp).toDate(),
  //       location = firestore['location'],
  //       description = firestore['description'],
  //       uid = firestore['uid'];
}