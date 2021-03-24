import 'package:flutter/material.dart';

class IlanCard extends StatelessWidget {
  final String isAdi;
  final String isDetay;
  final String isUcret;
  final String isZaman;
  final String yayinlayanMail;
  final String yayinlayanFotoUrl;
  final String isAdres;

  const IlanCard(
      {Key key,
      this.isAdi,
      this.isDetay,
      this.isUcret,
      this.isZaman,
      this.yayinlayanMail,
      this.isAdres,
      this.yayinlayanFotoUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Image.asset(
                "assets/images/kategoriler/$isAdi.jpg",
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: yayinlayanFotoUrl == null
                    ? AssetImage("assets/images/profil.png")
                    : NetworkImage(yayinlayanFotoUrl),
              ),
              title: Text(isAdi),
              subtitle: Text(
                isDetay,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(isUcret),
            ),
            //Flexible(flex: 1, child: Placeholder()),
          ],
        ),
      ),
    );
  }
}
