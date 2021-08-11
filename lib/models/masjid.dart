import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mosq/models/inventaris.dart';
import 'package:mosq/services/databases/inventaris.dart';
import 'package:mosq/services/databases/masjid.dart';

class Masjid {
  String? id;
  String? nama;
  MasjidDatabase dao = new MasjidDatabase();
  InventarisDatabase? inventarisDao;

  Masjid({
    this.id,
    this.nama,
  }) {
    inventarisDao = InventarisDatabase(collections: dao.inventarises(this));
  }

  static attributeName(String attribute) {
    var lang = {
      'nama': 'Nama',
    };
    return lang[attribute];
  }

  save() async {
    if (this.id == null) {
      return await this.dao.store(this);
    } else {
      return await this.dao.update(this);
    }
  }

  delete() async {
    return await this.dao.delete(this);
  }

  Stream<List<Inventaris>> get inventarises {
    Stream<QuerySnapshot> snapshots = inventarisDao!.get;
    return snapshots.map((snapshot) => snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
          return Inventaris(
              id: doc.id,
              nama: data['nama'],
              harga: data['harga'],
              jumlah: data['jumlah'],
              satuan: data['satuan'],
              total: data['total'],
              pathFoto: data['pathFoto'],
              dao: inventarisDao,
          );
        }).toList());
  }
}
