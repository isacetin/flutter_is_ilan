import 'package:flutter/material.dart';
import 'package:flutter_is_ilan/view/anasayfa.dart';
import 'package:flutter_is_ilan/view_model/FirebaseAuth.dart';
import 'package:provider/provider.dart';
import 'create_account.dart';
import 'home_page.dart';
import 'login_page.dart';

class Yonlendirme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var pageController = PageController(initialPage: 1);
    var _authProvider =
        Provider.of<FirebaseAuthService>(context, listen: true);
    return StreamBuilder(
      stream: _authProvider.durumTakip(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Anasayfa();
        } else {
          return PageView(
            controller: pageController,
            children: [
              LoginPage(),
              HomePage(pageController: pageController),
              CreateAccount(),
            ],
          );
        }
      },
    );
  }
}
