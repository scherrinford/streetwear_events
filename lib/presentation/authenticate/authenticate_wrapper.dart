import 'package:flutter/material.dart';
import 'package:streetwear_events/presentation/authenticate/login_screen.dart';
import 'package:streetwear_events/presentation/authenticate/sign_up_screen.dart';
import 'package:streetwear_events/presentation/home/Home.dart';

class AuthenticateWrapper extends StatefulWidget {
  @override
  _AuthenticateWrapperState createState()=>_AuthenticateWrapperState();
}

class _AuthenticateWrapperState extends State<AuthenticateWrapper>{
  
  bool showsignIn = true;

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