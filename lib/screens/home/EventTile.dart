import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:streetwear_events/screens/home/DetailScreen.dart';

class EventTile extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(top: 8.0),
      margin: EdgeInsets.all(20.0),
      height: 238,
      //constraints: BoxConstraints.tightFor(height: 221.0),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(10),
      //   color: Color(0xFFF2EFE5),
      //   image: new DecorationImage(
      //       image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
      //       fit: BoxFit.fitWidth
      //     ),
      //   boxShadow: [
      //     BoxShadow(
      //         spreadRadius: 0.1,
      //         offset: Offset.zero,
      //         blurRadius: 10.0,
      //     ),
      //   ],
      // ),
      child: Card(
        elevation: 5,
        color: Color(0xFFF2EFE5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () {
            return Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailScreen()));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: <Widget>[
              Container(
                  constraints: BoxConstraints.tightFor(height: 150.0),
                  child: Image(
                      image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                      fit: BoxFit.fitWidth
                  )
              ),
              ListTile(
                title: Text('The Enchanted Nightingale'),
                subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.only(
                //     //topLeft: Radius.circular(10),
                //     topRight: Radius.circular(10),
                //   ),
                // ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: <Widget>[
              //     TextButton(
              //       child: const Text('BUY TICKETS'),
              //       onPressed: () { /* ... */ },
              //     ),
              //     const SizedBox(width: 8),
              //     TextButton(
              //       child: const Text('LISTEN'),
              //       onPressed: () { /* ... */ },
              //     ),
              //     const SizedBox(width: 8),
              //   ],
              // ),
            ],
          ),
        ),

      ),
    );
  }

}