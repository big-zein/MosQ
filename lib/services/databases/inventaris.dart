import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mosq/models/inventaris.dart';

class InventarisDatabase {
  final CollectionReference collections;
  InventarisDatabase({
    required this.collections,
  });

  //Stream
  Stream<QuerySnapshot> get get {
    return collections.snapshots();
  }

  //Single
  Object getData(Inventaris model) {
    return {
      'nama': model.nama,
      'harga': model.harga,
      'jumlah': model.jumlah,
      'satuan': model.satuan,
      'total': model.calculateTotal(),
    };
  }
  Future store(Inventaris model) async {
    DocumentReference result = await collections.add(getData(model));
    model.id = result.id;
    return result;
  }
  Future update(Inventaris model) async {
    return await collections.doc(model.id).set(getData(model));
  }
  Future delete(Inventaris model) async {
    return await collections.doc(model.id).delete();
  }
}