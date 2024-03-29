import 'package:flutter/material.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: themeDarkColor,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final titleTextStyle = TextStyle(
  color: Color(0xFF393939),
  fontFamily: 'OpenSans',
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
);

final smallTitleTextStyle = TextStyle(
  color: Color(0xFF393939),
  fontFamily: 'OpenSans',
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
);

final themeDarkColor = Color(0xFF755540);
final themeLightColor = Color(0xFFF2EFE5);
final mainThemeColor = Color(0xFF755540);

final backgroundImage = AssetImage('assets/images/round-2-nyc-grand-opening-9.jpg');
final logoImage = AssetImage('assets/images/streetwear_events.png');

const kGoogleApiKey = "AIzaSyD7ttooB3TLfcGtyuV1XHhHJsKjt6MTmV8";