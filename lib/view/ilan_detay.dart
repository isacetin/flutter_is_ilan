import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
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
        title: Text(
          product['isAdi'],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Hero(
          tag: index,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.2,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: baslangicKonum,
                  onMapCreated: (GoogleMapController controller) {
                    haritaKontrol.complete(controller);
                  },
                ),
              ),
              Card(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: product['yayinlayanFtoUrl'] != null
                            ? NetworkImage(product['yayinlayanFtoUrl'])
                            : AssetImage("assets/images/profil.png"),
                      ),
                      title: Text(product['yayilayanMail']),
                      trailing: IconButton(
                        icon: Icon(Icons.call, color: Colors.blueAccent),
                        onPressed: () {},
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.work,
                        color: Colors.blueAccent,
                      ),
                      title: Text(product['isDetay']),
                    ),
                    ListTile(
                      leading: Icon(Icons.account_balance_wallet,
                          color: Colors.blueAccent),
                      title: Text(product['isUcret']),
                    ),
                    ListTile(
                      leading:
                      Icon(Icons.location_on, color: Colors.blueAccent),
                      title: Text(product['isAdres']),
                    ),
                    ListTile(
                        leading:
                        Icon(Icons.timer_sharp, color: Colors.blueAccent),
                        title: Text(
                            product['isZaman'].toString().substring(0, 10)),
                        subtitle:
                        Text(product['isZaman'].toString().substring(10)))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


/*                */