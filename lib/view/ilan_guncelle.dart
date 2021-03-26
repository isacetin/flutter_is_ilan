import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_is_ilan/model/ilan.dart';
import 'package:flutter_is_ilan/view_model/firesbase_firestore.dart';
import 'package:flutter_multi_formatter/formatters/money_input_formatter.dart';

class IlanGuncelle extends StatefulWidget {
  final DocumentSnapshot product;
  IlanGuncelle({Key key, this.product}) : super(key: key);

  @override
  _IlanGuncelleState createState() => _IlanGuncelleState();
}

class _IlanGuncelleState extends State<IlanGuncelle> {
  DateTime suankiTarih = DateTime.now();
  DateTime sonTarih = DateTime(2023, 1, 1);
  String isDetay, isucret, isAdres, secilenTarih, secilenKategori;
  var _formKey = GlobalKey<FormState>();

  List<DropdownMenuItem<String>> dropItems = [
    DropdownMenuItem(child: Text("Temizlik"), value: "Temizlik"),
    DropdownMenuItem(child: Text("Bakıcılık"), value: "Bakıcılık"),
    DropdownMenuItem(child: Text("Garson"), value: "Garson"),
    DropdownMenuItem(child: Text("Eğitim"), value: "Egitim"),
    DropdownMenuItem(child: Text("Diğer"), value: "Diger"),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    secilenKategori = widget.product['isAdi'];
    isDetay = widget.product['isDetay'];
    secilenTarih = widget.product['isZaman'];
    isucret = widget.product['isUcret'];
    isAdres = widget.product['isAdres'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                ilanGuncelle(widget.product);
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButton<String>(
                isExpanded: true,
                hint: Text(secilenKategori),
                items: dropItems,
                onChanged: (secilen) {
                  setState(() {
                    secilenKategori = secilen;
                  });
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                onSaved: (girilenDetay){
                  setState(() {
                    isDetay = girilenDetay;
                  });
                },
                initialValue: isDetay,
                maxLines: 3,
                decoration: InputDecoration(
                    labelText: "Detay", border: OutlineInputBorder()),
              ),
              SizedBox(height: 15),
              DateTimePicker(
                initialValue: secilenTarih,
                type: DateTimePickerType.dateTimeSeparate,
                dateMask: 'd MMM, yyyy',
                firstDate: suankiTarih,
                lastDate: sonTarih,
                dateLabelText: "Tarih",
                timeLabelText: "Saat",
                icon: Icon(Icons.event),
                onSaved: (gelenTarih) {
                  secilenTarih = gelenTarih;
                },
                validator: (girilenDeger) {
                  if (girilenDeger.length == 0) {
                    return "Lütfen Boş Geçmeyiniz";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                onSaved: (girilenAdres){
                  setState(() {
                    isAdres = girilenAdres;
                  });
                },
                initialValue: isAdres,
                decoration: InputDecoration(
                    labelText: "Adres", border: OutlineInputBorder()),
              ),
              SizedBox(height: 15),
              TextFormField(
                initialValue: isucret,
                inputFormatters: [
                  MoneyInputFormatter(leadingSymbol: MoneySymbols.DOLLAR_SIGN),
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onSaved: (girilenDeger) {
                  isucret = girilenDeger;
                },
                validator: (girilenDeger) {
                  if (girilenDeger.length == 0) {
                    return "Lütfen Boş Geçmeyiniz";
                  } else {
                    return null;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ilanGuncelle(DocumentSnapshot product) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await FirebaseFirestoreService().ilanGuncelle(
          product.id,
          IsIlan(
            isAdi: secilenKategori,
            isDetay: isDetay,
            isZaman: secilenTarih,
            isUcret: isucret,
            isAdres: isAdres,
          ));
      Navigator.pop(context);
    }
  }
}
