import 'package:flutter/material.dart';

///Model Class for Theme
class ThemeModel extends ChangeNotifier {
  static bool isDark = false;

  ///return  the current Theme of App
  ThemeMode currentTheme() {
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  /// Use to switch Themes
  void switchTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}
