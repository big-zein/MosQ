import 'package:flutter/material.dart';
import 'package:mosq/libraries/validator.dart';
import 'package:mosq/models/inventaris.dart';

class InventarisForm extends StatefulWidget {
  final Inventaris model;
  const InventarisForm({Key? key, required this.model}) : super(key: key);

  @override
  _InventarisFormState createState() => _InventarisFormState();
}

class _InventarisFormState extends State<InventarisForm> {
  final _formKey = GlobalKey<FormState>();
  final namaC = TextEditingController();
  final hargaC = TextEditingController();
  final jumlahC = TextEditingController();
  final satuanC = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var model = widget.model;
    if (model.id != null) {
      namaC.text = model.nama.toString();
      hargaC.text = model.harga.toString();
      jumlahC.text = model.jumlah.toString();
      satuanC.text = model.satuan.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
          key: _formKey,
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: namaC,
              decoration: InputDecoration(
                labelText: Inventaris.attributeName('nama'),
              ),
              textInputAction: TextInputAction.next,
              validator: (value) => (Validator(
                      attributeName: Inventaris.attributeName('nama'),
                      value: value)
                    ..required())
                  .getError(),
              onFieldSubmitted: (value) => _formKey.currentState!.validate(),
            ),
            TextFormField(
              controller: hargaC,
              decoration: InputDecoration(
                labelText: Inventaris.attributeName('harga'),
                prefixText: 'Rp ',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              validator: (value) => (Validator(
                      attributeName: Inventaris.attributeName('harga'),
                      value: value)
                    ..required()
                    ..integer()
                    ..min(10))
                  .getError(),
              onFieldSubmitted: (value) => _formKey.currentState!.validate(),
            ),
            TextFormField(
              controller: jumlahC,
              decoration: InputDecoration(
                labelText: Inventaris.attributeName('jumlah'),
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              validator: (value) => (Validator(
                      attributeName: Inventaris.attributeName('jumlah'),
                      value: value)
                    ..required()
                    ..integer()
                    ..min(0))
                  .getError(),
              onFieldSubmitted: (value) => _formKey.currentState!.validate(),
            ),
            TextFormField(
              controller: satuanC,
              decoration: InputDecoration(
                labelText: Inventaris.attributeName('satuan'),
              ),
              textInputAction: TextInputAction.done,
              validator: (value) => (Validator(
                      attributeName: Inventaris.attributeName('satuan'),
                      value: value)
                    ..required())
                  .getError(),
              onFieldSubmitted: (value) => _formKey.currentState!.validate(),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () async {
                    if (!isLoading && _formKey.currentState!.validate()) {
                      setState(() => isLoading = true);

                      var model = widget.model;
                      model.nama = namaC.text;
                      model.harga = int.parse(hargaC.text);
                      model.jumlah = int.parse(jumlahC.text);
                      model.satuan = satuanC.text;
                      await model.save();

                      Navigator.pop(context);

                      final snackBar = SnackBar(
                        content: Text("Data berhasil disimpan"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: !isLoading
                      ? Text('Simpan')
                      : SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )),
            ),
          ])),
    );
  }
}
