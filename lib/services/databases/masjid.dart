import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mosq/models/masjid.dart';
import 'package:mosq/models/user.dart';

class MasjidDatabase  {
  static final CollectionReference masjidCollection = FirebaseFirestore.instance.collection('masjids');

  CollectionReference inventarises(Masjid model) {
    return masjidCollection.doc(model.id).collection('inventarises');
  }

  Future<DocumentSnapshot> getMasjid(User model) async {
    return await masjidCollection.doc(model.masjidId).get();
  }
  Future store(Masjid model) async {
    DocumentReference result = await masjidCollection.add({
      'nama': model.nama,
    });
    model.id = result.id;
    return result;
  }
  Future update(Masjid model) async {
    return await masjidCollection.doc(model.id).set({
      'nama': model.nama,
    });
  }
  Future delete(Masjid model) async {
    return await masjidCollection.doc(model.id).delete();
  }
}