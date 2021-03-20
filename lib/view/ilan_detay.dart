import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IlanDetay extends StatelessWidget {
  // AIzaSyBzpmn8MvAVw6gnqlpBCc-2E15PfMBd1YU
  final String index;
  final DocumentSnapshot product;

  IlanDetay({Key key, this.index, this.product}) : super(key: key);

  Completer<GoogleMapController> haritaKontrol = Completer();
  var baslangicKonum =
      CameraPosition(target: LatLng(39.9035553,32.6223371), zoom: 6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: index,
        child: Column(
          children: [
            SizedBox(
              width: 400,
              height: 300,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: baslangicKonum,
                onMapCreated: (GoogleMapController controller){
                  haritaKontrol.complete(controller);
                },
              ),
            ),
            Divider(),
            Image.asset(
              "assets/images/kategoriler/${product["isAdi"]}.jpg",
            ),
            Text(product['idAdres']),
            Text(product['isAdi']),
            Text(product['isDetay']),
            Text(product['isUcret']),
            Text(product['isZaman']),
            Text(product['yayilayanMail']),
          ],
        ),
      ),
    );
  }
}
