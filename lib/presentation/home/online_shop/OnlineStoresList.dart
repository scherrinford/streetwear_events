import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:streetwear_events/data/models/store.dart';
import 'package:url_launcher/url_launcher.dart';

class OnlineStoresList extends StatefulWidget {
  @override
  State<OnlineStoresList> createState() => OnlineStoresListState();
}

class OnlineStoresListState extends State<OnlineStoresList> {

  Widget _storeCard(Store store){
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.album),
            title: Text(store.name),
            subtitle: Text(store.description),
            onTap: () async{
              var _url = Uri.parse(store.url);
              if (!await launchUrl(_url)) {
                throw 'Could not launch $_url';
              }
            },
          ),
        ],
      ),
    );
  }

  Stream<List<Store>> getOnlineStore(){
    return FirebaseFirestore.instance.collection('store').where("type", isEqualTo: "online").snapshots().map((snapshot)
    => snapshot.docs.map((doc) => Store.fromJson(doc.data())).toList());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Store>>(stream: getOnlineStore(), builder: (context, snapshot) {
      if (snapshot.hasError){
        return Text("No events here");
      }else if (snapshot.hasData){
        final _store = snapshot.data;
        return ListView(
          children: _store!.map(_storeCard).toList(),
        );
      }else{
        return Center(child: CircularProgressIndicator());
      }
    });
  }

}