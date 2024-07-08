import 'package:flutter/material.dart';
import 'package:pau_sosyal/theme/dark_mode.dart';
import 'package:pau_sosyal/theme/light_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UiProvider extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  late SharedPreferences storge;

  final darkTheme = darkMode;
  final lightTheme = lightMode;

  changeTheme() {
    _isDark = !isDark;
    storge.setBool("isDark", _isDark);
    notifyListeners();
  }

  init() async {
    storge = await SharedPreferences.getInstance();
    _isDark = storge.getBool("isDark") ?? false;
    notifyListeners();
  }
}
