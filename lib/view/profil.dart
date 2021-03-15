import 'package:flutter/material.dart';
import 'package:flutter_is_ilan/view_model/FirebaseAuth.dart';
import 'package:flutter_is_ilan/view_model/app_controller.dart';
import 'package:flutter_is_ilan/widgets/card_widget.dart';
import 'package:provider/provider.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  bool darkMi = false;

  @override
  Widget build(BuildContext context) {
    var _authProvider = Provider.of<FirebaseAuthService>(context, listen: true);
    var _appProvider = Provider.of<AppController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          CustomCardWidget(
            leading: Icon(Icons.person, size: 50),
            title: Text(_authProvider.kullaniciTakip().email.substring(
                0, _authProvider.kullaniciTakip().email.indexOf('@'))),
          ),
          CustomCardWidget(
            leading: Icon(
              Icons.email_outlined,
            ),
            title: Text(_authProvider.kullaniciTakip().email),
          ),
          CustomCardWidget(
            leading: Icon(
              Icons.phone,
            ),
            title: Text(_authProvider.kullaniciTakip().uid),
          ),
          SizedBox(height: 25),
          CustomCardWidget(
            leading: Icon(
              Icons.lock_open_outlined,
            ),
            title: Text("Şifremi Değiştir"),
          ),
          CustomCardWidget(
            leading: Icon(
              Icons.help_center_outlined,
            ),
            title: Text("Yardım"),
          ),
          CustomCardWidget(
            leading: Icon(
              Icons.exit_to_app_outlined,
            ),
            title: Text("Çıkış Yap"),
            onpress: () {
              _authProvider.cikisYap();
            },
          ),
          Card(
              child: SwitchListTile(
                  title: Text("Karanlık Mod"),
                  secondary: Icon(Icons.lightbulb),
                  value: _appProvider.themeGet(),
                  onChanged: (value) {
                    setState(() {
                      _appProvider.themeChange();
                    });
                  })),
        ],
      ),
    );
  }
}
