import 'package:flutter/material.dart';
import 'package:streetwear_events/screens/authenticate/login_screen.dart';
import 'package:streetwear_events/screens/authenticate/sign_up_screen.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState()=>_AuthenticateState();
}

class _AuthenticateState extends State<Authenticate>{
  
  bool showsignIn =true;
  void toogleView(){
    setState(()=>showsignIn = !showsignIn);
  }

  @override 
  Widget build(BuildContext context){
    if(showsignIn){
      return LoginScreen(toogleView: toogleView);
    }else{
      return SignUpScreen(toogleView: toogleView);
    }
  }
}