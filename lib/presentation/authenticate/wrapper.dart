import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streetwear_events/presentation/authenticate/authenticate_wrapper.dart';
import 'package:streetwear_events/presentation/authenticate/login_screen.dart';
import 'package:streetwear_events/presentation/authenticate/sign_up_screen.dart';
import 'package:streetwear_events/presentation/home/Home.dart';
import 'package:streetwear_events/data/services/auth.dart';
import 'package:streetwear_events/utilities/constants.dart';

import 'authenticate_wrapper.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  AuthService authService = AuthService();
  bool loading = false;

  Widget _loginButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AuthenticateWrapper())),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: themeDarkColor,
        child: Text(
          'LOGIN*',
          style: TextStyle(
            color: themeLightColor,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _loginAnonymousButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: _signInAnonymously,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: themeLightColor,
        child: Text(
          'USE WITHOUT LOGIN',
          style: TextStyle(
            color: themeDarkColor,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Text(
      'Streetwear event',
      style: TextStyle(
        color: themeDarkColor,
        fontFamily: 'OpenSans',
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _logoImage() {
    return Image(
      image: logoImage,
      height: 150.0,
    );
  }

  Widget _subText(){
    return Text(
      "*Only fot commercial users",
      style: TextStyle(
        color: themeDarkColor,
        fontFamily: 'OpenSans',
        fontSize: 10.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _wrapperView(){
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
        body: Container(
          margin: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _logoImage(),
                SizedBox(height: 30.0),
                _title(),
                SizedBox(height: 30.0),
                _loginAnonymousButton(),
                _loginButton(),
                _subText()
              ]),
        ));
  }

  @override
  Widget build(BuildContext context) {

    final FirebaseAuth auth = FirebaseAuth.instance;

    // final User? user = auth.currentUser;
    if(auth.currentUser!=null){
      return Home();
    }else{
      return _wrapperView();
    }
  }

  Future _signInAnonymously() async {
    print('Login Button Pressed');
    // setState(()=>loading=true);
    try{
      dynamic result = await authService.signInAnon();
      if(result !=null)
      {
        print('login anonymously');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    } on FirebaseAuthException catch(e){
      print(e);
      loading = false;
    }


  }
}
