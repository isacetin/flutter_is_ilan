class IsIlan {
  String isAdi;
  String isDetay;
  String isUcret;
  String isZaman;
  String isAdres;
  String yayilayanMail;
  String yayinlayanFotoUrl;

  IsIlan({this.isAdi,
    this.isDetay,
    this.isUcret,
    this.isZaman,
    this.isAdres,
    this.yayinlayanFotoUrl,
    this.yayilayanMail});

  IsIlan.fromMap(Map<String, dynamic> map)
      : isAdi = map["isAdi"],
        isDetay = map["isDetay"],
        isUcret = map["isUcret"],
        isZaman = map["isZaman"],
        isAdres = map["isAdres"],
        yayinlayanFotoUrl = map["yayinlayanFotoUrl"],
        yayilayanMail = map["yayilayanMail"];
}
