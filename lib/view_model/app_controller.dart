import 'package:flutter/cupertino.dart';

class AppController extends ChangeNotifier {
  bool isDark = false;

  bool themeGet() {
    return isDark;
  }

  void themeChange() {
    isDark = !isDark;
    notifyListeners();
  }
}
