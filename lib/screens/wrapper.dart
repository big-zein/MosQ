import 'package:flutter/material.dart';
import 'package:mosq/models/user.dart';
import 'package:mosq/screens/authentication/authentication.dart';
import 'package:mosq/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);
    return user == null ? Authentication() : Home() ;
  }
}
