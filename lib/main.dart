import 'package:flutter/material.dart';
import 'file:///C:/Users/bigel/AndroidStudioProjects/streetwear_events/lib/screens/authenticate/login_screen.dart';
import 'package:streetwear_events/screens/home/Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Home(),
    );
  }
}


