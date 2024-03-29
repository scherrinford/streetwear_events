import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.pink[400],
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.pink,
          size: 50,
        ),
      ),
    );
  }
}