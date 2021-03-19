import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_is_ilan/view/ilan_olusturma.dart';
import 'package:flutter_is_ilan/view/ilanlar.dart';
import 'package:flutter_is_ilan/view/profil.dart';

class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  var sayfaIndex = 0;

  @override
  Widget build(BuildContext context) {
    var pageController = PageController();
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            sayfaIndex = index;
          });
        },
        children: [
          Ilanlar(),
          IlanEkleme(),
          Profil(),
        ],
      ),
      bottomNavigationBar: buildCurvedNavigationBar(context, pageController),
    );
  }

  CurvedNavigationBar buildCurvedNavigationBar(
          BuildContext context, PageController pagecontroller) =>
      CurvedNavigationBar(
        onTap: (index) {
          setState(() {
            sayfaIndex = index;
            pagecontroller.jumpToPage(sayfaIndex);
          });
        },
        index: sayfaIndex,
        backgroundColor: Theme.of(context).backgroundColor,
        height: 50,
        color: Colors.white,
        items: [
          Icon(Icons.home, size: 30, color: Colors.black),
          Icon(Icons.add, size: 30, color: Colors.black),
          Icon(Icons.person, size: 30, color: Colors.black),
        ],
      );
}
