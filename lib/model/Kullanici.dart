import 'package:flutter/cupertino.dart';

class Kullanici {
  String id;
  String kullaniciAd;
  String kullaniciSoyad;
  String email;
  String profilUrl = " ";

  Kullanici(
      {@required this.id,
      @required this.email,
      this.kullaniciAd,
      this.kullaniciSoyad,
      this.profilUrl});

  Map<String, dynamic> toMap() {
    return {
      "kullanıcıId": id,
      "kullanıcıAd": kullaniciAd,
      "kullaniciSoyad": kullaniciSoyad,
      "e-mail": email,
      "profilUrl": profilUrl,
    };
  }

  Kullanici.fromMap(Map<String, dynamic> map)
      : id = map["kullaniciID"],
        kullaniciAd = map["kullaniciAd"],
        kullaniciSoyad = map["kullaniciSoyad"],
        email = map["e-mail"],
        profilUrl = map["fotoUrl"];

  @override
  String toString() {
    return 'Kullanici{id: $id, kullaniciAd: $kullaniciAd, email: $email, profilUrl: $profilUrl}';
  }
}
