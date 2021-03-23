import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  final PageController pageController;

  const HomePage({Key key, this.pageController}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String onboardImage = 'assets/svg/welcome.svg';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> loadPictures() async {
    await precachePicture(
        ExactAssetPicture((SvgPicture.svgStringDecoder), onboardImage), null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Lottie.asset("assets/lottie/work.json", height: 250),
            Column(
              children: [
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
          ],
        ),
      ),
    );
  }

  void pageChange(int page) {
    widget.pageController.animateToPage(page,
        duration: Duration(seconds: 1), curve: Curves.easeIn);
  }
}
