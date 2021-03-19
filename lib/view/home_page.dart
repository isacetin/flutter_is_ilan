import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  final PageController pageController;

  const HomePage({Key key, this.pageController}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/svg/welcome.svg"),
            ElevatedButton(
                child: Text("HESAP OLUŞTUR"),
                onPressed: () {
                  pageChange(2);
                }),
            ElevatedButton(
                child: Text("GİRİŞ YAP"),
                onPressed: () {
                  pageChange(0);
                })
          ],
        ),
      ),
    );
  }

  void pageChange(int page) {
    widget.pageController.animateToPage(page,
        duration: Duration(seconds: 1), curve: Curves.easeInOutQuad);
  }
}
