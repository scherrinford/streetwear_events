import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:streetwear_events/models/AppUser.dart';
import 'package:streetwear_events/models/Event.dart';
import 'package:streetwear_events/providers/event_dao.dart';
import 'package:streetwear_events/screens/home/Home.dart';
import 'package:provider/provider.dart';
import 'package:streetwear_events/services/auth.dart';
import 'package:streetwear_events/services/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<AppUser>.value(value:AuthService().user,initialData: null,),
          StreamProvider<List<Event>>.value(value:DatabaseService().getProducts(),initialData: []),
          StreamProvider<List<UserData>>.value(value:DatabaseService().getUsersList(), initialData: []),
          // TODO: Add ChangeNotifierProvider<UserDao> here
          // Provider<Event>(
          // lazy: false,
          // create: (_) => User(),
          // ),
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            home: Home(),
         )
    );
  }
}


