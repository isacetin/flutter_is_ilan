import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_is_ilan/widgets/card_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IlanDetay extends StatelessWidget {
  // AIzaSyBzpmn8MvAVw6gnqlpBCc-2E15PfMBd1YU
  final String index;
  final DocumentSnapshot product;

  IlanDetay({Key key, this.index, this.product}) : super(key: key);

  Completer<GoogleMapController> haritaKontrol = Completer();
  var baslangicKonum =
      CameraPosition(target: LatLng(39.9035553, 32.6223371), zoom: 6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Hero(
          tag: index,
          child: Column(
            children: [
              SizedBox(
                width: 400,
                height: 300,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: baslangicKonum,
                  onMapCreated: (GoogleMapController controller) {
                    haritaKontrol.complete(controller);
                  },
                ),
              ),
              Divider(),
              Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: product['yayinlayanFtoUrl'] != null
                        ? NetworkImage(product['yayinlayanFtoUrl'])
                        : AssetImage("assets/images/profil.png"),
                  ),
                  title: Text(product['yayilayanMail']),
                  subtitle: Text(product['isAdi']),
                  trailing: IconButton(
                    icon: Icon(Icons.call, color: Colors.blueAccent),
                    onPressed: () {},
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.work,
                    color: Colors.blueAccent,
                  ),
                  title: Text(product['isDetay']),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.account_balance_wallet,
                      color: Colors.blueAccent),
                  title: Text(product['isUcret']),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.location_on, color: Colors.blueAccent),
                  title: Text(product['isAdres']),
                ),
              ),
              Card(
                child: ListTile(
                    leading: Icon(Icons.timer_sharp, color: Colors.blueAccent),
                    title: Text(product['isZaman'].toString().substring(0, 10)),
                    subtitle:
                        Text(product['isZaman'].toString().substring(10))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
