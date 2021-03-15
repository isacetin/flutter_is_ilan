import 'package:flutter/cupertino.dart';

class Kullanici {
  String id;
  String kullaniciAd;
  String email;
  String profilUrl = " ";

  Kullanici(
      {@required this.id,
      @required this.email,
      this.kullaniciAd,
      this.profilUrl});

  Map<String, dynamic> toMap() {
    return {
      "kullanıcıId": id,
      "kullanıcıAd": kullaniciAd,
      "e-mail": email,
      "profilUrl": profilUrl,
    };
  }

  Kullanici.fromMap(Map<String, dynamic> map)
      : id = map["kullaniciID"],
        kullaniciAd = map["kullaniciAd"],
        email = map["e-mail"],
        profilUrl = map["fotoUrl"];

  @override
  String toString() {
    return 'Kullanici{id: $id, kullaniciAd: $kullaniciAd, email: $email, profilUrl: $profilUrl}';
  }
}
