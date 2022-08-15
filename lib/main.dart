import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:streetwear_events/models/user_data.dart';
import 'package:streetwear_events/models/Event.dart';
import 'package:streetwear_events/screens/authenticate/authenticate_wrapper.dart';
import 'package:streetwear_events/screens/authenticate/wrapper.dart';
import 'package:streetwear_events/screens/home/Home.dart';
import 'package:provider/provider.dart';
import 'package:streetwear_events/services/auth.dart';
import 'package:streetwear_events/services/database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();

  final AuthService _authService = AuthService();
  final DatabaseService _databaseService = DatabaseService(uid: null);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          //StreamProvider(create: (context) => AuthService().user, initialData: null,),
          Provider.value(value: _authService),
          Provider.value(value: _databaseService),
          StreamProvider<UserData?>.value(
              value: _authService.user,
              initialData: null
          ),
          StreamProvider<List<Event>>.value(
              value: _databaseService.events,
              initialData: [],
          ),
          StreamProvider<List<UserData>>.value(
              value: _databaseService.getUsersList(),
              initialData: []
          ),
          // Provider<Event>(
          // lazy: false,
          // create: (_) => User(),
          // ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          home: Wrapper(),
        ));
  }
}
