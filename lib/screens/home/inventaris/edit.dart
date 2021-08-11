import 'package:flutter/material.dart';
import 'package:mosq/models/inventaris.dart';
import 'package:mosq/screens/home/inventaris/_form.dart';
import 'package:mosq/screens/home/inventaris/builder.dart';

class InventarisEdit extends StatelessWidget {
  const InventarisEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = ModalRoute.of(context)!.settings.arguments as Inventaris;

    return InventarisBuilder(
        builder: (context, snapshot) => Scaffold(
          backgroundColor: Colors.blue[50],
          appBar: AppBar(
            title: Text('Ubah Inventaris'),
            backgroundColor: Colors.blue[400],
          ),
          body: InventarisForm(
              model: model),
        ));
  }
}
