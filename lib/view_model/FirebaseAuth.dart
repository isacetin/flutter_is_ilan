import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_is_ilan/model/Kullanici.dart';
import 'package:flutter_is_ilan/view_model/firesbase_firestore.dart';

class FirebaseAuthService extends ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Kullanici kullanici;
  String aktifKullaniciId;

  User kullaniciTakip() {
    return _firebaseAuth.currentUser;
  }

  Future<Kullanici> kullaniciNesneOlustur(User user) async{
    kullanici = await FirebaseFirestoreService().cloudKullaniciGetir(user.uid);
    return kullanici;
  }

  Stream<User> durumTakip() {
    return _firebaseAuth.authStateChanges();
  }

  Future<Kullanici> createUserEmailandPassword(
      String email, String password) async {
    try {
      UserCredential uyeOlankullanici = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      //FireStoreCloud Kullanıcı Ekleme
      await FirebaseFirestoreService().cloudkullaniciOlustur(uyeOlankullanici.user);
      return kullaniciNesneOlustur(uyeOlankullanici.user);

    } catch (e) {
      print("createUserEmailandPassword Hata Oluştu : $e");
      return null;
    }
  }

  Future<Kullanici> loginUserandPassword(String email, String password) async {
    try {
      UserCredential girisYapanKullanici = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return kullaniciNesneOlustur(girisYapanKullanici.user);
    } catch (e) {
      print("loginUserandPassword Hata Oluştu : $e");
      return null;
    }
  }

  sifreSifirla() async{
    await _firebaseAuth.sendPasswordResetEmail(email: kullaniciTakip().email);
  }

  Future<void> cikisYap() async {
    var cikisYapanKullanici = await _firebaseAuth.signOut();
    return cikisYapanKullanici;
  }
}
