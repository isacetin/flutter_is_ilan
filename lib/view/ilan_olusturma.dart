import 'package:flutter/material.dart';
import 'package:flutter_is_ilan/model/is_ilan.dart';
import 'package:flutter_is_ilan/view_model/FirebaseAuth.dart';
import 'package:flutter_is_ilan/view_model/firesbase_firestore.dart';
import 'package:provider/provider.dart';

class IlanEkleme extends StatefulWidget {
  @override
  _IlanEklemeState createState() => _IlanEklemeState();
}

class _IlanEklemeState extends State<IlanEkleme> {
  int aktifStep = 0;
  String isBilgi, adres, ucret;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("İlan Ekle"), elevation: 0),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Stepper(
            steps: _tumStepler(formKey),
            currentStep: aktifStep,
            onStepTapped: (tiklanilanStep) {
              setState(() {
                aktifStep = tiklanilanStep;
              });
            },
            onStepContinue: () {
              if (aktifStep < _tumStepler(formKey).length - 1) {
                setState(() {
                  aktifStep++;
                });
              }
            },
            onStepCancel: () {
              if (aktifStep > 0) {
                setState(() {
                  aktifStep--;
                });
              } else {
                aktifStep = 0;
              }
            },
          ),
        ),
      ),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    var _autProvider = Provider.of<FirebaseAuthService>(context);
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        formKey.currentState.save();
        IsIlan yeniIsIlan = IsIlan(isAdi: "is Adı",isDetay:isBilgi,isUcret: ucret,isAdres: adres,isZaman: "54'de");
        print(isBilgi + " + " + ucret + " + " + adres);
        FirebaseFirestoreService().IsKaydet(_autProvider.kullaniciTakip().uid, yeniIsIlan);
      },
    );
  }

  List<Step> _tumStepler(GlobalKey formKey) {
    List<Step> stepler = [
      Step(
        title: Text("İş"),
        subtitle: Text("İş Bilgilerinizi Giriniz"),
        state: StepState.indexed,
        isActive: true,
        content: TextFormField(
          decoration: InputDecoration(border: OutlineInputBorder()),
          onSaved: (girilenDeger) {
            isBilgi = girilenDeger;
          },
        ),
      ),
      Step(
        title: Text("Adres"),
        subtitle: Text("Adres Bilgilerini Giriniz"),
        state: StepState.indexed,
        isActive: true,
        content: TextFormField(
          decoration: InputDecoration(border: OutlineInputBorder()),
          onSaved: (girilenDeger) {
            adres = girilenDeger;
          },
        ),
      ),
      Step(
        title: Text("Ücret"),
        subtitle: Text("Ücret Bilgilerini Giriniz"),
        state: StepState.indexed,
        isActive: true,
        content: TextFormField(
          decoration: InputDecoration(border: OutlineInputBorder()),
          onSaved: (girilenDeger) {
            ucret = girilenDeger;
          },
        ),
      ),
    ];

    return stepler;
  }
}
