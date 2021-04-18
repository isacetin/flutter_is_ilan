import 'package:flutter/material.dart';

class IlanCard extends StatelessWidget {
  final String isAdi;
  final String isDetay;
  final String isUcret;
  final String isZaman;
  final String yayinlayanMail;
  final String yayinlayanFotoUrl;
  final String isAdres;

  const IlanCard(
      {Key key,
      this.isAdi,
      this.isDetay,
      this.isUcret,
      this.isZaman,
      this.yayinlayanMail,
      this.isAdres,
      this.yayinlayanFotoUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 1.1,
            height: MediaQuery.of(context).size.height / 5,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/kategoriler/$isAdi.jpg"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.1,
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(blurRadius: 2, spreadRadius: 1, color: Colors.grey)
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      backgroundImage: yayinlayanFotoUrl == null
                          ? AssetImage("assets/images/profil.png")
                          : NetworkImage(yayinlayanFotoUrl),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isAdi,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                      Text(
                        isDetay,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Chip(
                  backgroundColor: Color(0xFF9EDE73),
                  label: Text(
                    isUcret,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
