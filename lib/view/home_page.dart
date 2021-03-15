import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  final PageController pageController;

  const HomePage({Key key, this.pageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/lottie/work.json"),
          SizedBox(height: 150),
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
    );
  }

  void pageChange(int page) {
    pageController.animateToPage(page,
        duration: Duration(seconds: 1), curve: Curves.easeInOutQuad);
  }
}
