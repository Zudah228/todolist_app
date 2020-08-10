import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier{
  AppTheme() : dark = false;
  bool dark;

  ThemeData buildTheme()
  => dark ? ThemeData.dark() : ThemeData.light();

  void changedMode() {
    dark = !dark;
    notifyListeners();
  }
}