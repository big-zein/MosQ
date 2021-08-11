import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mosq/models/user.dart';

class UserDatabase {
  static final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  static Stream<QuerySnapshot> get get {
    return userCollection.snapshots();
  }

  Future<DocumentSnapshot> find(User model) async {
    return await userCollection.doc(model.id).get();
  }
  Future update(User model) async {
    return await userCollection.doc(model.id).set({
      'masjid_uid': model.masjidId,
    });
  }
  Future delete(User model) async {
    return await userCollection.doc(model.id).delete();
  }
}