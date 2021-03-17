import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_is_ilan/model/Kullanici.dart';
import 'package:flutter_is_ilan/model/ilan.dart';

class FirebaseFirestoreService extends ChangeNotifier {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> cloudkullaniciOlustur(User kullanici) async {
    await _firebaseFirestore.collection("kullanicilar").doc(kullanici.uid).set({
      "kullaniciID": kullanici.uid,
      "e-mail": kullanici.email,
      "kullaniciAd": kullanici.email.substring(0, kullanici.email.indexOf('@')),
      "fotoUrl": kullanici.photoURL,
    }).then((value) => print("**********Kullanici Eklendi**********"));
  }

  cloudKullaniciGetir(String userId) async {
    DocumentSnapshot doc =
        await _firebaseFirestore.collection("kullanicilar").doc(userId).get();
    Map<String, dynamic> okunanMap = doc.data();
    Kullanici kullanici = Kullanici.fromMap(okunanMap);
    print("Okunan User : " + kullanici.toString());
    return kullanici;
  }

  Future<void> IsKaydet(IsIlan isIlan) async{
    try{
      await _firebaseFirestore.collection("isler").doc().set({
        "isAdi" : isIlan.isAdi,
        "İdAdres" : isIlan.isAdres,
        "isDetay" : isIlan.isDetay,
        "isUcret" : isIlan.isUcret,
        "isZaman" : isIlan.isZaman,
        "yayilayanMail" : isIlan.yayilayanMail
      }).then((value) => {
        print("İş Başarıyla Eklendi")
      });
    }catch(e){
      print("İs Kayıt Ederken Hata $e");
    }
  }

}
