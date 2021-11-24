import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:streetwear_events/screens/home/AppDrawer.dart';

import 'AppBar.dart';

class DetailScreen extends StatefulWidget{


  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF755540),
          title: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        endDrawer: AppDrawer(),
        body: new Container(
          //height: 238,
          //constraints: BoxConstraints.tightFor(height: 221.0),
          decoration: BoxDecoration(
            color: Color(0xFFF2EFE5),
            image: new DecorationImage(
                image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
          ),
          child: Card(
            elevation: 25,
            color: Color(0xFFF2EFE5),
            margin: const EdgeInsets.only(top: 200),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
              ),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ListTile(
                    title: Text('The Enchanted Nightingale'),
                    subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text('BUY TICKETS'),
                        onPressed: () { /* ... */ },
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        child: const Text('LISTEN'),
                        onPressed: () { /* ... */ },
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }
}