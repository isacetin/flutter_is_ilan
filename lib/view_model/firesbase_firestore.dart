import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_is_ilan/model/Kullanici.dart';
import 'package:flutter_is_ilan/model/ilan.dart';
import 'package:flutter_is_ilan/view_model/FirebaseAuth.dart';

import '../model/ilan.dart';

class FirebaseFirestoreService extends ChangeNotifier {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  DateTime ilanYayinTarihi = DateTime.now();

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

  // ignore: non_constant_identifier_names
  Future<void> IsKaydet(IsIlan isIlan) async {
    try {
      return await _firebaseFirestore.collection("isler").doc().set({
        "isAdi": isIlan.isAdi,
        "isAdres": isIlan.isAdres,
        "isDetay": isIlan.isDetay,
        "isUcret": isIlan.isUcret,
        "isZaman": isIlan.isZaman,
        "isYayinTarihi": ilanYayinTarihi,
        "yayilayanMail": isIlan.yayilayanMail,
        "yayinlayanFtoUrl": isIlan.yayinlayanFotoUrl
      }).then((value) => {print("İş Başarıyla Eklendi")});
    } catch (e) {
      print("İs Kayıt Ederken Hata $e");
      return null;
    }
  }

  ilanGetir(String kategori) async {
    QuerySnapshot ilanlar;
    if (kategori == "Tümü") {
      ilanlar = await _firebaseFirestore
          .collection("isler")
          .orderBy("isYayinTarihi", descending: true)
          .get();
    } else {
      ilanlar = await _firebaseFirestore
          .collection("isler")
          .where('isAdi', isEqualTo: kategori)
          .get();
    }
    return ilanlar;
  }

  profilSahibiIlanGetir() async {
    try {
      QuerySnapshot ilanlar = await _firebaseFirestore
          .collection("isler")
          .where('yayilayanMail',
              isEqualTo: FirebaseAuthService().kullaniciTakip().email)
          .get();
      return ilanlar;
    } catch (e) {
      print("profilSahibiIlanGetir Hata : " + e.toString());
    }
  }

  ilanSil(String docId) async {
    try {
      await _firebaseFirestore.collection("isler").doc(docId).delete();
    } catch (e) {
      print("İlan Silde Hata : " + e.toString());
    }
  }

  ilanGuncelle(String docId, IsIlan isIlan) async {
    try {
      await _firebaseFirestore.collection("isler").doc(docId).update({
        "isAdi": isIlan.isAdi,
        "isAdres": isIlan.isAdres,
        "isDetay": isIlan.isDetay,
        "isUcret": isIlan.isUcret,
        "isZaman": isIlan.isZaman,
      }).then((value) => print("****Ilan Güncellendi****"));
    } catch (e) {
      print("Ilan Güncellemede Hata : $e");
    }
  }
}
