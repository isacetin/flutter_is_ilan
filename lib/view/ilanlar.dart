import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
      body: FutureBuilder(
          future: FirebaseFirestoreService().ilanGetir(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  reverse: true,
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
