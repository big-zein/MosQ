import 'package:flutter/material.dart';
import 'package:mosq/models/user.dart';
import 'package:provider/provider.dart';

class InventarisBuilder extends StatelessWidget {
  final Function builder;
  const InventarisBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);

    return FutureBuilder(
        future: user!.loadMasjid(),
        builder: (context, snapshot) =>
            user.masjid == null ? Container() : builder(context, snapshot) );
  }
}
