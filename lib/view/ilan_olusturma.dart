import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_is_ilan/model/ilan.dart';
import 'package:flutter_is_ilan/view_model/FirebaseAuth.dart';
import 'package:flutter_is_ilan/view_model/firesbase_firestore.dart';
import 'package:flutter_multi_formatter/formatters/money_input_formatter.dart';
import 'package:provider/provider.dart';

class IlanEkleme extends StatefulWidget {
  @override
  _IlanEklemeState createState() => _IlanEklemeState();
}

class _IlanEklemeState extends State<IlanEkleme> {
  final snackBar = SnackBar(
      content: Text('Başarıyla Eklendi'), backgroundColor: Colors.green);
  List<DropdownMenuItem<String>> dropItems = [
    DropdownMenuItem(child: Text("Temizlik"), value: "Temizlik"),
    DropdownMenuItem(child: Text("Bakıcılık"), value: "Bakıcılık"),
    DropdownMenuItem(child: Text("Garson"), value: "Garson"),
    DropdownMenuItem(child: Text("Eğitim"), value: "Egitim"),
    DropdownMenuItem(child: Text("Diğer"), value: "Diger"),
  ];
  int aktifStep = 0;
  String isBilgi, adres, ucret;
  var formKey = GlobalKey<FormState>();
  bool hata = false;
  bool sonStepMi = false;
  String secilenKategori = "Seçiniz";
  DateTime suankiTarih = DateTime.now();
  DateTime sonTarih = DateTime(2023, 1, 1);
  String secilenTarih = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("İLAN EKLE"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Stepper(
            controlsBuilder: (BuildContext context,
                {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
              return devamGeriButtonRow(onStepContinue, onStepCancel);
            },
            steps: _tumStepler(formKey),
            currentStep: aktifStep,
            onStepContinue: () {
              setState(() {
                if (aktifStep < _tumStepler(formKey).length - 1) {
                  aktifStep++;
                  if (aktifStep == 4) {
                    sonStepMi = !sonStepMi;
                  } else {
                    sonStepMi = false;
                  }
                }
              });
            },
            onStepCancel: () {
              if (aktifStep > 0) {
                setState(() {
                  aktifStep--;
                  if (aktifStep == 4) {
                    sonStepMi = !sonStepMi;
                  } else {
                    sonStepMi = false;
                  }
                });
              } else {
                aktifStep = 0;
              }
            },
            onStepTapped: (tiklanilanStep) {
              setState(() {
                aktifStep = tiklanilanStep;
              });
            },
          ),
        ),
      ),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  Row devamGeriButtonRow(
      VoidCallback onStepContinue, VoidCallback onStepCancel) {
    return Row(
      children: <Widget>[
        ElevatedButton(
          onPressed: sonStepMi ? null : onStepContinue,
          child: const Text('Devam Et'),
        ),
        SizedBox(width: 30),
        TextButton(
          onPressed: onStepCancel,
          child: const Text('Geri Gel'),
        ),
      ],
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    var _autProvider = Provider.of<FirebaseAuthService>(context);
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            IsIlan yeniIsIlan = IsIlan(
                isAdi: secilenKategori,
                isDetay: isBilgi,
                isUcret: ucret,
                isAdres: adres,
                yayilayanMail: _autProvider.kullaniciTakip().email,
                isZaman: secilenTarih);
            FirebaseFirestoreService().IsKaydet(yeniIsIlan).then((value) {
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            });
            setState(() {
              formKey.currentState.reset();
              aktifStep = 0;
              sonStepMi = false;
            });
          }
        });
  }

  List<Step> _tumStepler(GlobalKey formKey) {
    List<Step> stepler = [
      Step(
        title: Text("Kategori"),
        subtitle: Text("İş Kategori Seçiniz"),
        state: _stateleriAyarla(0),
        isActive: true,
        content: DropdownButton<String>(
          isExpanded: true,
          hint: Text(secilenKategori),
          items: dropItems,
          onChanged: (secilen) {
            setState(() {
              secilenKategori = secilen;
            });
          },
        ),
      ),
      Step(
        title: Text("İş"),
        subtitle: Text("İş'in Detaylarını Giriniz"),
        state: _stateleriAyarla(1),
        isActive: true,
        content: TextFormField(
          decoration: InputDecoration(border: OutlineInputBorder()),
          maxLines: 3,
          onSaved: (girilenDeger) {
            isBilgi = girilenDeger;
          },
          validator: (girilenDeger) {
            if (girilenDeger.length == 0) {
              return "Lütfen Boş Geçmeyiniz";
            } else {
              return null;
            }
          },
        ),
      ),
      Step(
        title: Text("Tarih / Saat"),
        subtitle: Text("Tarih ve Saati Giriniz"),
        state: _stateleriAyarla(2),
        isActive: true,
        content: DateTimePicker(
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
      ),
      Step(
        title: Text("Adres"),
        subtitle: Text("Adres Bilgilerini Giriniz"),
        state: _stateleriAyarla(3),
        isActive: true,
        content: TextFormField(
          decoration: InputDecoration(border: OutlineInputBorder()),
          onSaved: (girilenDeger) {
            adres = girilenDeger;
          },
          validator: (girilenDeger) {
            if (girilenDeger.length == 0) {
              return "Lütfen Boş Geçmeyiniz";
            } else {
              return null;
            }
          },
        ),
      ),
      Step(
        title: Text("Ücret"),
        subtitle: Text("Ücret Bilgilerini Giriniz"),
        state: _stateleriAyarla(4),
        isActive: true,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              inputFormatters: [
                MoneyInputFormatter(leadingSymbol: MoneySymbols.DOLLAR_SIGN),
              ],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              onSaved: (girilenDeger) {
                ucret = girilenDeger;
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
    ];

    return stepler;
  }

  StepState _stateleriAyarla(int oankiStep) {
    if (aktifStep == oankiStep) {
      return StepState.editing;
    } else {
      return StepState.indexed;
    }
  }
}
