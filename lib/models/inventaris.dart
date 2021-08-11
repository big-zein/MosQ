import 'package:mosq/services/databases/inventaris.dart';

class Inventaris {
  String? id;
  String? nama;
  int? harga;
  int? jumlah;
  String? satuan;
  int? total;
  String? pathFoto;
  InventarisDatabase? dao;

  Inventaris({
    this.id,
    this.nama,
    this.harga,
    this.jumlah,
    this.satuan,
    this.total,
    this.pathFoto,
    this.dao
  });

  static attributeName(String attribute) {
    var lang = {
      'nama': 'Nama',
      'harga': 'Harga',
      'jumlah': 'Jumlah',
      'satuan': 'Satuan',
      'total': 'Total',
      'pathFoto': 'Foto',
    };
    return lang[attribute];
  }

  save() async {
    if (this.id == null) {
      return await dao!.store(this);
    } else {
      return await dao!.update(this);
    }
  }

  delete() async {
    return await dao!.delete(this);
  }

  calculateTotal() {
    return harga! * jumlah!;
  }

}
