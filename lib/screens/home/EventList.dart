import 'package:flutter/cupertino.dart';

import 'EventTile.dart';

class EventList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: <Widget>[
          EventTile(),
          EventTile(),
          EventTile(),
          EventTile(),
        ]
    );
  }

}
