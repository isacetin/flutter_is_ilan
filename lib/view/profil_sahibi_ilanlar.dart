import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_is_ilan/view_model/firesbase_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share/share.dart';

import 'ilan_detay.dart';
import 'ilan_guncelle.dart';

class ProfilSahibiIlanlar extends StatefulWidget {
  @override
  _ProfilSahibiIlanlarState createState() => _ProfilSahibiIlanlarState();
}

class _ProfilSahibiIlanlarState extends State<ProfilSahibiIlanlar> {
  final snackBar = SnackBar(
      content: Text('Başarıyla Silindi'), backgroundColor: Colors.green);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestoreService().profilSahibiIlanGetir(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot product = snapshot.data.docs[index];
              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigoAccent,
                      backgroundImage: product['yayinlayanFtoUrl'] == null
                          ? AssetImage("assets/images/profil.png")
                          : NetworkImage(product['yayinlayanFtoUrl']),
                      foregroundColor: Colors.white,
                    ),
                    title: Text(product['isAdi'],
                        style: TextStyle(color: Colors.black)),
                    subtitle: Text(product['isDetay'],
                        style: TextStyle(color: Colors.black)),
                    trailing: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IlanDetay(
                            index: index.toString(),
                            product: product,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Sil',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () {
                      setState(() {
                        FirebaseFirestoreService().ilanSil(product.id);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  ),
                  IconSlideAction(
                    caption: 'Güncelle',
                    color: Colors.green,
                    icon: Icons.share,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IlanGuncelle(
                                    product: product,
                                  )));
                    },
                  ),
                  IconSlideAction(
                    caption: 'Paylaş',
                    color: Colors.indigo,
                    icon: Icons.share,
                    onTap: () {
                      Share.share(
                          'https://play.google.com/store/apps/developer?id=%C4%B0sa+%C3%87etin');
                    },
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}
