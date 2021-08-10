import 'package:flutter/material.dart';
import 'package:mosq/screens/authentication/sign_in.dart';
import 'package:mosq/screens/authentication/sign_up.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showSignIn
          ? SignIn(toggleView: toggleView)
          : SignUp(toggleView: toggleView),
    );
  }
}
