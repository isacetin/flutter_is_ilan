import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_is_ilan/model/ilan.dart';
import 'package:flutter_is_ilan/view_model/firesbase_firestore.dart';
import 'package:flutter_is_ilan/widgets/ilan_card.dart';

class Ilanlar extends StatefulWidget {
  @override
  _IlanlarState createState() => _IlanlarState();
}

class _IlanlarState extends State<Ilanlar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection("isler").get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot product = snapshot.data.docs[index];
                    return IlanCard(
                      isAdi: product['isAdi'],
                      isDetay: product['isDetay'],
                      isUcret: product['isUcret'],
                    );

                  });
            }
          }),
    );
  }
}
