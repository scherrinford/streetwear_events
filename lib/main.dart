import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:streetwear_events/data/models/user_data.dart';
import 'package:streetwear_events/data/models/event.dart';
import 'package:streetwear_events/presentation/authenticate/authenticate_wrapper.dart';
import 'package:streetwear_events/presentation/authenticate/wrapper.dart';
import 'package:streetwear_events/presentation/home/Home.dart';
import 'package:provider/provider.dart';
import 'package:streetwear_events/data/services/auth.dart';
import 'package:streetwear_events/data/services/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserData?>.value(
        value: AuthService().user,
        initialData: null,
        child: MaterialApp(
          title: 'Flutter Demo',
          home: Wrapper(),
        ));
  }
}
