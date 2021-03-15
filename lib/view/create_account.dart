import 'package:flutter/material.dart';
import 'package:flutter_is_ilan/view_model/FirebaseAuth.dart';
import 'package:flutter_is_ilan/view_model/firesbase_firestore.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  var _formKey = GlobalKey<FormState>();
  String _email, _sifre;
  bool _sifreGizliMi = true;

  @override
  Widget build(BuildContext context) {
    var _authProvider =
        Provider.of<FirebaseAuthService>(context, listen: false);
    var _cloudProvider =
        Provider.of<FirebaseFirestoreService>(context, listen: false);
    return Scaffold(
        body: ListView(
      children: [
        Lottie.asset("assets/lottie/register_work.json", height: 250),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  onSaved: (girilenDeger) {
                    _email = girilenDeger;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "E-mail"),
                  validator: (girilenDeger) {
                    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(girilenDeger) !=
                        true) {
                      return "Lütfen Geçerli Bir Mail Giriniz";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  onSaved: (girilenDeger) {
                    _sifre = girilenDeger;
                  },
                  obscureText: _sifreGizliMi,
                  decoration: InputDecoration(
                      labelText: "Şifre",
                      suffixIcon: IconButton(
                        icon: _sifreGizliMi
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _sifreGizliMi = !_sifreGizliMi;
                          });
                        },
                      )),
                  validator: (girilenDeger) {
                    if (girilenDeger.length < 6) {
                      return "Şifre 6 Karakterden Az Olamaz";
                    } else {
                      return null;
                    }
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                         await _authProvider
                            .createUserEmailandPassword(_email, _sifre);
                      }
                    },
                    child: Text("Kayıt Ol"))
              ],
            ),
          ),
        )
      ],
    ));
  }
}
