import 'package:flutter/material.dart';
import 'package:mosq/models/inventaris.dart';
import 'package:mosq/models/user.dart';
import 'package:mosq/screens/home/inventaris/builder.dart';
import 'package:provider/provider.dart';

class InventarisIndex extends StatefulWidget {
  const InventarisIndex({Key? key}) : super(key: key);

  @override
  _InventarisIndexState createState() => _InventarisIndexState();
}

class _InventarisIndexState extends State<InventarisIndex> {
  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);

    return InventarisBuilder(
        builder: (context, snapshot) => StreamProvider<List<Inventaris>>.value(
            initialData: [],
            value: user!.masjid!.inventarises,
            child: Scaffold(
              backgroundColor: Colors.blue[50],
              appBar: AppBar(
                title: Text('Inventaris'),
                backgroundColor: Colors.blue[400],
              ),
              body: Index(),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/inventaris/create');
                },
                child: Icon(Icons.add),
              ),
            )));
  }
}

class Index extends StatelessWidget {
  const Index({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inventarises = Provider.of<List<Inventaris>>(context);
    return Padding(
        padding: EdgeInsets.only(top: 8),
        child: inventarises.length == 0
            ? Card(
                margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                child: ListTile(
                  title: Text('Data masih kosong'),
                ),
              )
            : ListView.builder(
                itemCount: inventarises.length,
                itemBuilder: (context, index) {
                  return Tile(model: inventarises[index]);
                }));
  }
}

class Tile extends StatelessWidget {
  final Inventaris model;

  const Tile({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(model.id.toString()),
      background: Container(
        color: Colors.orange,
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Icon(Icons.edit),
            SizedBox(
              width: 10,
            ),
            Text("Edit"),
          ],
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("Delete"),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.delete),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        bool res = false;
        if (direction == DismissDirection.endToStart) {
          res = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Hapus Data?'),
                    content: Text(
                        "Anda akan menghapus data '${model.nama}'. Data yang sudah dihapus tidak dapat dikembalikan."),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: Text('Tidak')),
                      TextButton(
                          onPressed: () async {
                            Navigator.pop(context, true);
                          },
                          child: Text('Hapus')),
                    ],
                  ));
        }
        return res;
      },
      onDismissed: (direction) async {
        if (direction == DismissDirection.endToStart) {
          await model.delete();
        }
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, '/inventaris/show', arguments: model),
          child: ListTile(
            title: Text(model.nama.toString()),
            subtitle: Text("Rp ${model.harga.toString()} x ${model.jumlah.toString()} ${model.satuan.toString()} = ${model.total.toString()}", textAlign: TextAlign.right,),
            leading: Icon(Icons.update),
          ),
        ),
      ),
    );
  }
}
