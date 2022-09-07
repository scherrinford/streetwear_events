import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:streetwear_events/data/models/user_data.dart';

class Event{
  final String id;
  final String name;
  final String description;
  final String location;
  final String uid;
  final DateTime date;
  //final String city;
  //final String photoUrl;


  Event({
    this.id = '',
    required this.name,
    required this.description,
    required this.location,
    required this.uid,
    required this.date,
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

  static Stream<List<Event>> getListOfEventsByUser(String uid){
    return FirebaseFirestore.instance.collection('events').where("uid", isEqualTo: uid).snapshots().map((snapshot)
    => snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList());
  }

  static Event fromJson(Map<String,dynamic> data) => Event(
      name: data['name'],
      description: data['description'],
      location: data['location'],
      uid: data['uid'],
      date: (data['date'] as Timestamp).toDate(),
  );

  factory Event.fromFirestore( DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options, ){
    final data = snapshot.data();
    return Event(
        uid: data!['uid'],
        name: data['name'],
        description: data['description'],
        location: data['location'],
        id: data['id'],
        date: data['date']
    );
  }

  Event.fromSnapchot(DocumentSnapshot snapshot)
      : id = snapshot['id'],
        name = snapshot['name'],
        date = (snapshot['date'] as Timestamp).toDate(),
        location = snapshot['location'],
        description = snapshot['description'],
        uid = snapshot['uid'];

  // Event.fromFirestore(Map<String, dynamic> firestore)
  //     : eventId = firestore['eventId'],
  //       name = firestore['name'],
  //       date = (firestore['date'] as Timestamp).toDate(),
  //       location = firestore['location'],
  //       description = firestore['description'],
  //       uid = firestore['uid'];
}