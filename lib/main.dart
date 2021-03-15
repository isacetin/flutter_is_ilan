import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_is_ilan/view/yonlendirme.dart';
import 'package:flutter_is_ilan/view_model/FirebaseAuth.dart';
import 'package:flutter_is_ilan/view_model/app_controller.dart';
import 'package:flutter_is_ilan/view_model/firesbase_firestore.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<FirebaseAuthService>(
        create: (_) => FirebaseAuthService()),
    ChangeNotifierProvider<AppController>(create: (_) => AppController()),
    ChangeNotifierProvider<FirebaseFirestoreService>(create: (_) => FirebaseFirestoreService()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: context.watch<AppController>().themeGet() == true
            ? ThemeData.dark()
            : ThemeData(
                primarySwatch: Colors.deepOrange,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
        /*theme: */
        home: Yonlendirme());
  }
}