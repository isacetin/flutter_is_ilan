import 'package:flutter/material.dart';
import 'package:flutter_is_ilan/view_model/FirebaseAuth.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    var _authProvider = Provider.of<FirebaseAuthService>(context, listen: false);
    String _email, _sifre;
    return Scaffold(
        body: ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/lottie/login_work.json"),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: "deneme@deneme.com",
                        decoration: InputDecoration(labelText: "E-mail"),
                        onSaved: (girilenDeger) {
                          _email = girilenDeger;
                        },
                        validator: (girilenDeger) {
                          if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(girilenDeger) !=
                              true) {
                            return "Lütfen Geçerli Bir Mail Giriniz";
                          } else {
                            return null;
                          }
                        }),
                    TextFormField(
                      initialValue: "123456",
                      decoration: InputDecoration(labelText: "Şifre",),
                      onSaved: (girilenDeger) {
                        _sifre = girilenDeger;
                      },
                      validator: (girilenDeger) {
                        if (girilenDeger.length < 6) {
                          return "Şifre 6 Karakterden Az Olamaz";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      child: Text("Giriş Yap"),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          _authProvider.loginUserandPassword(_email, _sifre);
                        }
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ],
    ));
  }
}
