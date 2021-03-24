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
  String secilenKategori = "Tümü";
  List<String> kategoriler = [
    "Tümü",
    "Bakıcılık",
    "Eğitim",
    "Garson",
    "Kasiyer",
    "Montaj",
    "Temizlik",
    "Diğer"
  ];

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
            future: FirebaseFirestoreService().ilanGetir(secilenKategori),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: kategoriler.length,
                          itemBuilder: (context, index) {
                            return kategoriChip(kategoriler[index]);
                          }),
                    ),
                    Expanded(
                      flex: 9,
                      child: ListView.builder(
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
                                yayinlayanFotoUrl: product['yayinlayanFtoUrl'],
                              ),
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
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<Null> _sayfaYenile() async {
    setState(() {});
    return null;
  }

  Widget kategoriChip(String label) {
    return InkWell(
      onTap: () {
        setState(() {
          secilenKategori = label;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Chip(
          label: Text(label),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
