import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_is_ilan/view/ilan_detay.dart';
import 'package:flutter_is_ilan/view_model/firesbase_firestore.dart';
import 'package:flutter_is_ilan/widgets/ilan_card.dart';

class Ilanlar extends StatefulWidget {
  @override
  _IlanlarState createState() => _IlanlarState();
}

class _IlanlarState extends State<Ilanlar> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            "İLANLAR",
            style: TextStyle(fontFamily: 'Roboto'),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _sayfaYenile,
          child: FutureBuilder(
              future: FirebaseFirestoreService().ilanGetir(),
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
                        return InkWell(
                          child: Hero(
                            tag: index,
                            child: IlanCard(
                              isAdi: product['isAdi'],
                              isDetay: product['isDetay'],
                              isUcret: product['isUcret'],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => IlanDetay(
                                          index: index.toString(),
                                          product: product,
                                        )));
                          },
                        );
                      });
                }
              }),
        ),
      ),
    );
  }

  Future<Null> _sayfaYenile() async {
    setState(() {});
    return null;
  }
}
