import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_is_ilan/model/Kullanici.dart';
import 'package:flutter_is_ilan/model/ilan.dart';
import 'package:flutter_is_ilan/view_model/FirebaseAuth.dart';

import '../model/ilan.dart';

class FirebaseFirestoreService extends ChangeNotifier {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> cloudkullaniciOlustur(User kullanici) async {
    await _firebaseFirestore.collection("kullanicilar").doc(kullanici.uid).set({
      "kullaniciID": kullanici.uid,
      "e-mail": kullanici.email,
      "kullaniciAd": " ",
      "kullaniciSoyad": " ",
      "fotoUrl": kullanici.photoURL,
    }).then((value) => print("**********Kullanici Eklendi**********"));
  }

  Future<Kullanici> cloudKullaniciGetir() async {
    DocumentSnapshot doc = await _firebaseFirestore
        .collection("kullanicilar")
        .doc(FirebaseAuthService().kullaniciTakip().uid)
        .get();
    Kullanici kullanici;
    if (doc.exists) {
      Map<String, dynamic> okunanMap = doc.data();
      kullanici = Kullanici.fromMap(okunanMap);
    }
    return kullanici;
  }

  Future<void> cloudKullaniciGuncelle(
      String kullaniciAd, String kullaniciSoyad, String profilFotoUrl) async {
    await _firebaseFirestore
        .collection("kullanicilar")
        .doc(FirebaseAuthService().kullaniciTakip().uid)
        .update({
      "kullaniciAd": kullaniciAd,
      "kullaniciSoyad": kullaniciSoyad,
      "fotoUrl": profilFotoUrl,
    });
  }

  Future<void> IsKaydet(IsIlan isIlan) async {
    try {
      return await _firebaseFirestore.collection("isler").doc().set({
        "isAdi": isIlan.isAdi,
        "isAdres": isIlan.isAdres,
        "isDetay": isIlan.isDetay,
        "isUcret": isIlan.isUcret,
        "isZaman": isIlan.isZaman,
        "yayilayanMail": isIlan.yayilayanMail,
        "yayinlayanFtoUrl": isIlan.yayinlayanFotoUrl
      }).then((value) => {print("İş Başarıyla Eklendi")});
    } catch (e) {
      print("İs Kayıt Ederken Hata $e");
      return null;
    }
  }

  ilanGetir() async {
    QuerySnapshot ilanlar =
        await FirebaseFirestore.instance.collection("isler").get();
    return ilanlar;
  }
}
