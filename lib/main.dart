import 'package:flutter/material.dart';
import 'package:mosq/models/user.dart';
import 'package:mosq/screens/wrapper.dart';
import 'package:mosq/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamProvider<User?>.value(
                value: AuthService().user,
                initialData: null,
                child: MaterialApp(
                  title: 'Flutter Demo',
                  home: Wrapper(),
                ));
          }
          return MaterialApp(
            title: 'Flutter Demo',
            home: Text('Loading...'),
          );
        });
  }
}
