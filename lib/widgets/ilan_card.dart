import 'package:flutter/material.dart';

class IlanCard extends StatelessWidget {
  final String isAdi;
  final String isDetay;
  final String isUcret;
  final String isZaman;
  final String yayinlayanMail;
  final String isAdres;

  const IlanCard(
      {Key key,
      this.isAdi,
      this.isDetay,
      this.isUcret,
      this.isZaman,
      this.yayinlayanMail,
      this.isAdres})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2.3,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              "assets/images/kategoriler/$isAdi.jpg",
              fit: BoxFit.fill,
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/images/profil.png"),
              ),
              title: Text(isAdi),
              subtitle: Text(isDetay),
              trailing: Text(isUcret),
            ),
            //Flexible(flex: 1, child: Placeholder()),
          ],
        ),
      ),
    );
  }
}
