class IsIlan {
  String isAdi;
  String isDetay;
  String isUcret;
  String isZaman;
  String isAdres;
  String yayilayanMail;

  IsIlan(
      {this.isAdi,
      this.isDetay,
      this.isUcret,
      this.isZaman,
      this.isAdres,
      this.yayilayanMail});

  IsIlan.fromMap(Map<String, dynamic> map)
      : isAdi = map["isAdi"],
        isDetay = map["isDetay"],
        isUcret = map["isUcret"],
        isZaman = map["isZaman"],
        isAdres = map["isAdres"],
        yayilayanMail = map["yayilayanMail"];
}
