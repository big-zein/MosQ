import 'package:flutter/material.dart';
import 'package:mosq/models/inventaris.dart';
import 'package:mosq/models/user.dart';
import 'package:mosq/screens/home/inventaris/_form.dart';
import 'package:mosq/screens/home/inventaris/builder.dart';
import 'package:provider/provider.dart';

class InventarisCreate extends StatelessWidget {
  const InventarisCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);

    return InventarisBuilder(
        builder: (context, snapshot) => Scaffold(
              backgroundColor: Colors.blue[50],
              appBar: AppBar(
                title: Text('Tambah Inventaris'),
                backgroundColor: Colors.blue[400],
              ),
              body: InventarisForm(
                  model: new Inventaris(dao: user!.masjid!.inventarisDao)),
            ));
  }
}
