import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_is_ilan/model/Kullanici.dart';
import 'package:flutter_is_ilan/view_model/FirebaseAuth.dart';
import 'package:flutter_is_ilan/view_model/app_controller.dart';
import 'package:flutter_is_ilan/view_model/firesbase_firestore.dart';
import 'package:flutter_is_ilan/widgets/card_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  FocusNode myFocusNode;
  FocusNode myFocusNode2;
  String kullaniciAd, kullaniciSoyad;
  var _formKey = GlobalKey<FormState>();
  bool darkMi = false;
  var snackBar = SnackBar(
    content: Text(
      'Şifrenizi sıfırlamak için mailinizi kontrol ediniz.',
      style: TextStyle(color: Colors.black),
    ),
  );
  var snackBar2 = SnackBar(
      content: Text(
        'Adınız ve Soyadınız Güncellenmiştir.',
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.green);

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    myFocusNode2 = FocusNode();
  }
  @override
  void dispose() {
    super.dispose();
    myFocusNode.dispose();
    myFocusNode2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _authProvider = Provider.of<FirebaseAuthService>(context, listen: true);
    var _appProvider = Provider.of<AppController>(context, listen: false);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: buildAppBar(),
      ),
      body: FutureBuilder<Kullanici>(
        future: FirebaseFirestoreService().cloudKullaniciGetir(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                SizedBox(height: 15),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/profil.png"),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 10))
                            ]),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 35),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        focusNode: myFocusNode,
                        autofocus: false,
                        initialValue: snapshot.data.kullaniciAd,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: "İsim",
                        ),
                        onSaved: (girilenAd) {
                          kullaniciAd = girilenAd;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        focusNode: myFocusNode2,
                        autofocus: false,
                        initialValue: snapshot.data.kullaniciSoyad,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 3),
                            labelText: "Soyisim"),
                        onSaved: (girilenAd) {
                          kullaniciSoyad = girilenAd;
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      child: Text(
                        "KAYDET",
                        style: TextStyle(letterSpacing: 2, fontSize: 14),
                      ),
                      onPressed: () {
                        _formKey.currentState.save();
                        FirebaseFirestoreService().cloudKullaniciGuncelle(
                            kullaniciAd, kullaniciSoyad);
                        myFocusNode.unfocus();
                        myFocusNode2.unfocus();
                        ScaffoldMessenger.of(context).showSnackBar(snackBar2);
                      },
                    ),
                  ],
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
                CustomCardWidget(
                  leading: Icon(
                    Icons.exit_to_app_outlined,
                  ),
                  title: Text("Çıkış Yap"),
                  onpress: () {
                    _authProvider.cikisYap();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text("Profil"),
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

  Widget buildTextField(String labelTextt, String hintTextt) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35),
      child: TextFormField(
        initialValue: hintTextt,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelTextt,
        ),
      ),
    );
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
