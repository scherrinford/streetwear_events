//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:streetwear_events/models/userr.dart';
// import 'package:streetwear_events/screens/authenticate/Authenticate.dart';
// import 'package:streetwear_events/screens/authenticate/login_screen.dart';
// import 'package:streetwear_events/screens/home/Home.dart';
// import 'package:streetwear_events/utilities/constants.dart';
// import 'package:streetwear_events/screens/authenticate/sign_up_screen.dart';
// import 'package:provider/provider.dart';
//
//
// class Wrapper extends StatelessWidget{
//   @override
//   Widget build(BuildContext context){
//
//     final user =Provider.of<Userr>(context);
//     print(user);
//     if(user == null){
//       return Authenticate();
//     }else {
//       return Home();
//     }
//   }
// }