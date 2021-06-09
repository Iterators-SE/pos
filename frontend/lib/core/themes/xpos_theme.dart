import 'package:flutter/material.dart';
import 'config.dart';

class XPosTheme extends ChangeNotifier {
  static final primaryColor = 0xFF7EBCC4;
  static final backgroundColor = 0xfffefefe;
  static bool _isDarkTheme = false;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: xposGreen,
      scaffoldBackgroundColor: Color(backgroundColor),
      fontFamily: 'Montserrat',
      buttonTheme: ButtonThemeData(
        buttonColor: xposGreen[50],
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: xposGreen[50],
      ),
    );
  }
}
