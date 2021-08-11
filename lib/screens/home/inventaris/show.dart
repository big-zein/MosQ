import 'package:flutter/material.dart';
import 'package:mosq/models/inventaris.dart';
import 'package:mosq/screens/home/inventaris/builder.dart';

class InventarisShow extends StatelessWidget {
  const InventarisShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = ModalRoute.of(context)!.settings.arguments as Inventaris;

    return InventarisBuilder(
        builder: (context, snapshot) => Scaffold(
              backgroundColor: Colors.blue[50],
              appBar: AppBar(
                title: Text('Lihat Inventaris'),
                backgroundColor: Colors.blue[400],
                actions: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/inventaris/edit',
                          ModalRoute.withName('/inventaris/index'),
                          arguments: model);
                    },
                  ),
                ],
              ),
              body: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(Inventaris.attributeName('nama')),
                      subtitle: Text(model.nama.toString()),
                    ),
                    ListTile(
                      title: Text(Inventaris.attributeName('harga')),
                      subtitle: Text(
                        model.harga.toString(),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    ListTile(
                      title: Text(Inventaris.attributeName('jumlah')),
                      subtitle: Text(
                          "${model.jumlah.toString()} ${model.satuan.toString()}",
                          textAlign: TextAlign.right),
                    ),
                    ListTile(
                      title: Text(Inventaris.attributeName('total')),
                      subtitle: Text(model.total.toString(),
                          textAlign: TextAlign.right),
                    ),
                  ],
                ),
              ),
            ));
  }
}
