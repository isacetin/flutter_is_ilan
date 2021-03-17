import 'package:flutter/material.dart';

class IlanCard extends StatelessWidget {

 final String isAdi;
 final String isDetay;
 final String isUcret;

  const IlanCard({Key key, this.isAdi, this.isDetay, this.isUcret}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(isAdi),
        subtitle: Text(isDetay),
        trailing: Text(isUcret),
      ),
    );
  }
}
