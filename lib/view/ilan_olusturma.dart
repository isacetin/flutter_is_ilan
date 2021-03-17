import 'package:flutter/material.dart';
import 'package:flutter_is_ilan/model/ilan.dart';
import 'package:flutter_is_ilan/view_model/FirebaseAuth.dart';
import 'package:flutter_is_ilan/view_model/firesbase_firestore.dart';
import 'package:provider/provider.dart';

class IlanEkleme extends StatefulWidget {
  @override
  _IlanEklemeState createState() => _IlanEklemeState();
}

class _IlanEklemeState extends State<IlanEkleme> {
  final snackBar = SnackBar(content: Text('Başarıyla Eklendi'),backgroundColor: Colors.green,);

  int aktifStep = 0;
  String isBilgi, adres, ucret;
  var formKey = GlobalKey<FormState>();
  bool hata = false;
  bool sonStepMi = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Stepper(
            controlsBuilder: (BuildContext context,
                {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
              return Row(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: sonStepMi ? null :  onStepContinue,
                    child: const Text('Devam Et'),
                  ),
                  SizedBox(width: 30),
                  TextButton(
                    onPressed: onStepCancel,
                    child: const Text('Geri Gel'),
                  ),
                ],
              );
            },
            steps: _tumStepler(formKey),
            currentStep: aktifStep,
            onStepContinue: () {
              setState(() {
                if (aktifStep < _tumStepler(formKey).length - 1) {
                  aktifStep++;
                  if(aktifStep == 2){
                    sonStepMi = !sonStepMi;
                  }else{
                    sonStepMi = false;
                  }
                }
              });
            },
            onStepCancel: () {
              if (aktifStep > 0) {
                setState(() {
                  aktifStep--;
                  if(aktifStep == 2){
                    sonStepMi = !sonStepMi;
                  }else{
                    sonStepMi = false;
                  }
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
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            IsIlan yeniIsIlan = IsIlan(
                isAdi: "is Adı",
                isDetay: isBilgi,
                isUcret: ucret,
                isAdres: adres,
                yayilayanMail: _autProvider.kullaniciTakip().email,
                isZaman: "54'de");
            FirebaseFirestoreService()
                .IsKaydet(yeniIsIlan)
                .then((value) {
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            });
            setState(() {
              formKey.currentState.reset();
              aktifStep = 0;
            });
          }
        });
  }

  List<Step> _tumStepler(GlobalKey formKey) {
    List<Step> stepler = [
      Step(
        title: Text("İş"),
        subtitle: Text("İş Bilgilerinizi Giriniz"),
        state: _stateleriAyarla(0),
        isActive: true,
        content: TextFormField(
          decoration: InputDecoration(border: OutlineInputBorder()),
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
        title: Text("Adres"),
        subtitle: Text("Adres Bilgilerini Giriniz"),
        state: _stateleriAyarla(1),
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
        state: _stateleriAyarla(2),
        isActive: true,
        content: TextFormField(
          decoration: InputDecoration(border: OutlineInputBorder()),
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
