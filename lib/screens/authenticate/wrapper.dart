import 'package:flutter/material.dart';
import 'package:streetwear_events/screens/authenticate/authenticate_wrapper.dart';
import 'package:streetwear_events/screens/authenticate/login_screen.dart';
import 'package:streetwear_events/screens/authenticate/sign_up_screen.dart';
import 'package:streetwear_events/screens/home/Home.dart';

import 'authenticate_wrapper.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState()=>_WrapperState();
}

class _WrapperState extends State<Wrapper>{



  Widget _loginButton(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
          elevation: 5.0,
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthenticateWrapper())),
          padding: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.black87,
      child: Text(
        'LOGIN',
        style: TextStyle(
          color: Color(0xFF527DAA),
          letterSpacing: 1.5,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      ),
    ),
    );
  }

  Widget _loginAnonimusButton(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
          elevation: 5.0,
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home())),
          padding: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.black87,
      child: Text(
        'USE WITHOUT LOGIN',
        style: TextStyle(
          color: Color(0xFF527DAA),
          letterSpacing: 1.5,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      ),
    ),
    );
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF755540),
        // title: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("onPressed: onPressed, child: child")
              // _loginAnonimusButton(),
              // _loginButton(),
          ]
      ),
    );

  }
}