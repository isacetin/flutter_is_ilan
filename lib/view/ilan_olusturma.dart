import 'package:flutter/material.dart';

class IlanEkleme extends StatefulWidget {
  @override
  _IlanEklemeState createState() => _IlanEklemeState();
}

class _IlanEklemeState extends State<IlanEkleme> {
  int aktifStep = 0;
  String isBilgi, adres, ucret;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("İlan Ekle"), elevation: 0),
      body: SingleChildScrollView(
        child: Stepper(
          steps: _tumStepler(),
          currentStep: aktifStep,
          onStepTapped: (tiklanilanStep) {
            setState(() {
              aktifStep = tiklanilanStep;
            });
          },
          onStepContinue: () {
            if (aktifStep < _tumStepler().length - 1) {
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
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {},
    );
  }

  List<Step> _tumStepler() {
    List<Step> stepler = [
      Step(
        title: Text("İş"),
        subtitle: Text("İş Bilgilerinizi Giriniz"),
        state: StepState.indexed,
        isActive: true,
        content: TextFormField(
          decoration: InputDecoration(border: OutlineInputBorder()),
        ),
      ),
      Step(
        title: Text("Adres"),
        subtitle: Text("Adres Bilgilerini Giriniz"),
        state: StepState.indexed,
        isActive: true,
        content: TextFormField(
            decoration: InputDecoration(border: OutlineInputBorder())),
      ),
      Step(
        title: Text("Ücret"),
        subtitle: Text("Ücret Bilgilerini Giriniz"),
        state: StepState.indexed,
        isActive: true,
        content: TextFormField(
            decoration: InputDecoration(border: OutlineInputBorder())),
      ),
    ];

    return stepler;
  }
}
