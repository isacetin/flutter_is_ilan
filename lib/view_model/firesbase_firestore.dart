import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_is_ilan/model/Kullanici.dart';

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

  IsKaydet() async{}
}
