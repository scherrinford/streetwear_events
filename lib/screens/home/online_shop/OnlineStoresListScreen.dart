import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:streetwear_events/models/store.dart';
import 'package:streetwear_events/utilities/constants.dart';

import 'OnlineStoresList.dart';

class OnlineStoresListScreen extends StatefulWidget {
  @override
  State<OnlineStoresListScreen> createState() => OnlineStoresListScreenState();
}

class OnlineStoresListScreenState extends State<OnlineStoresListScreen> {

  Widget _storeCard(Store store){
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.album),
            title: Text(store.name),
            subtitle: Text(store.description),
            // onTap: (){
            //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailScreen(event: event)));
            // },
          ),
        ],
      ),
    );
  }

  Stream<List<Store>> getOnlineStore(){
    return FirebaseFirestore.instance.collection('store').where("type", isEqualTo: "online").snapshots().map((snapshot)
    => snapshot.docs.map((doc) => Store.fromJson(doc.data())).toList());
  }

  Widget _onlineStoreList(){
    return  StreamBuilder<List<Store>>(stream: getOnlineStore(), builder: (context, snapshot) {
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

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: const EdgeInsets.only(top: 20,left: 20, right: 20),
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height,
        child: Column(
        children: [
          Text("Checkout Our Partners Online Stores:", style: titleTextStyle,),
          SizedBox(height: 20),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: OnlineStoresList()
          ),

        ],
    ));

  }

}