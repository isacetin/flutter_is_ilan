import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_is_ilan/view_model/FirebaseAuth.dart';
import 'package:flutter_is_ilan/view_model/app_controller.dart';
import 'package:flutter_is_ilan/widgets/card_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  bool darkMi = false;
  var snackBar = SnackBar(
      content: Text(
        'Şifrenizi sıfırlamak için mailinizi kontrol ediniz.',
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.yellow);

  @override
  Widget build(BuildContext context) {
    var _authProvider = Provider.of<FirebaseAuthService>(context, listen: true);
    var _appProvider = Provider.of<AppController>(context, listen: false);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: buildAppBar(),
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
            onpress: () => _resetPassword(),
          ),
          CustomCardWidget(
            leading: Icon(
              Icons.help_center_outlined,
            ),
            title: Text("Yardım"),
            onpress: () => _showDialog(),
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
                  secondary: Icon(Icons.brightness_2),
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

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        "Profil",
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
      elevation: 0,
      centerTitle: true,
    );
  }

  _showDialog() {
    showAboutDialog(
        context: context,
        applicationName: 'İSA ÇETİN',
        applicationIcon: FlutterLogo(),
        applicationVersion: '0.0.1',
        children: [
          ListTile(title: Text('Öneri ve Şikayetleriniz İçin')),
          ListTile(
            onTap: () => _lauchEmail(),
            leading: Icon(Icons.mail_outline),
            title: Text('isacetinn@outlook.com'),
          ),
          ListTile(
            onTap: () => _launchURL(),
            leading: Icon(Icons.person_add),
            title: Text('@isacetinn'),
          ),
        ]);
  }

  _lauchEmail() async {
    await launch("mailto:isacetinn@outlookcom");
  }

  _launchURL() async {
    var url = 'https://www.instagram.com/isacetinn/';
    if (await canLaunch(url)) {
      await launch(url, universalLinksOnly: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  _resetPassword() async {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Şifremi Değiştir!"),
              content: new Text(
                  "Şifre sıfırlama linki mail adresinize gönderilecektir."),
              actions: <Widget>[
                TextButton.icon(
                  icon: Icon(Icons.save),
                  label: Text('ONAYLA'),
                  onPressed: () {
                    context.read<FirebaseAuthService>().sifreSifirla();
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                ),
                TextButton.icon(
                  icon: Icon(Icons.clear),
                  label: Text('İPTAL!'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }
}
