import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IlanDetay extends StatefulWidget {
  // AIzaSyBzpmn8MvAVw6gnqlpBCc-2E15PfMBd1YU
  final String index;
  final DocumentSnapshot product;

  IlanDetay({Key key, this.index, this.product}) : super(key: key);

  @override
  _IlanDetayState createState() => _IlanDetayState();
}

class _IlanDetayState extends State<IlanDetay> {
  final Completer<GoogleMapController> haritaKontrol = Completer();
  var baslangicKonum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product['isAdi'],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: FutureBuilder(
        future: veriGetir(widget.product['isAdres']),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: Hero(
                tag: widget.index,
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
                    Divider(),
                    Card(
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  widget.product['yayinlayanFtoUrl'] != null
                                      ? NetworkImage(
                                          widget.product['yayinlayanFtoUrl'])
                                      : AssetImage("assets/images/profil.png"),
                            ),
                            title: Text(widget.product['yayilayanMail']),
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
                            title: Text(widget.product['isDetay']),
                          ),
                          ListTile(
                            leading: Icon(Icons.account_balance_wallet,
                                color: Colors.blueAccent),
                            title: Text(widget.product['isUcret']),
                          ),
                          ListTile(
                            leading: Icon(Icons.location_on,
                                color: Colors.blueAccent),
                            title: Text(widget.product['isAdres']),
                          ),
                          ListTile(
                              leading: Icon(Icons.timer_sharp,
                                  color: Colors.blueAccent),
                              title: Text(widget.product['isZaman']
                                  .toString()
                                  .substring(0, 10)),
                              subtitle: Text(widget.product['isZaman']
                                  .toString()
                                  .substring(10)))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  veriGetir(String sehir) async {
    final url = 'https://api.opencagedata.com/geocode/v1/json?q=$sehir&key=c76c3efc2a7b4b5fbf2324a2368af52b';
    final response = await Dio().get(url);
    baslangicKonum =  CameraPosition(
        target: LatLng(response.data['results'][0]['geometry']['lat'],
        response.data['results'][0]['geometry']['lng']),
    zoom: 8);
    return baslangicKonum;
  }
}
