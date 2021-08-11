import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mosq/models/masjid.dart';
import 'package:mosq/services/databases/inventaris.dart';
import 'package:mosq/services/databases/masjid.dart';
import 'package:mosq/services/databases/user.dart';

class User {
  final String id;
  String? email;
  String? password;
  String? displayName;
  String? phoneNumber;
  String? masjidId;
  UserDatabase? dao = UserDatabase();
  Masjid? masjid;
  InventarisDatabase? inventarisDao;

  User({
    required this.id,
    this.email,
    this.displayName,
    this.phoneNumber,
    this.masjidId,
  });

  static attributeName(String attribute) {
    var lang = {
      'email': 'Email',
      'password': 'Password',
      'displayName': 'Name',
      'phoneNumber': 'Phone Number',
      'masjidId': 'Masjid',
    };
    return lang[attribute];
  }

  save() async {
    return await this.dao!.update(this);
  }
  delete() async {
    return await this.dao!.delete(this);
  }

  Future loadUser() async {
    if (masjidId != null) {
      return;
    }
    DocumentSnapshot snapshot = await UserDatabase().find(this);
    var data = snapshot.data() as Map<String, dynamic>;
    masjidId = data['masjid_id'];
  }
  Future loadMasjid() async {
    if (masjid != null) {
      return;
    }
    await loadUser();
    DocumentSnapshot snapshot = await MasjidDatabase().getMasjid(this);
    var data = snapshot.data() as Map<String, dynamic>;
    masjid = Masjid(id: snapshot.id, nama: data['nama']);
    return snapshot;
  }
}
