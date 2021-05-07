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
      // primaryColor: Color(primaryColor),
      scaffoldBackgroundColor: Color(backgroundColor),
      fontFamily: 'Montserrat',
      buttonTheme: ButtonThemeData(
        buttonColor: xposGreen[500],
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: xposGreen[500],
      ),
    );
  }

  // TODO: change color palette for dark mode
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Color(primaryColor),
      scaffoldBackgroundColor: Color(backgroundColor),
      fontFamily: 'Montserrat',
      buttonTheme: ButtonThemeData(
        buttonColor: Color(primaryColor),
      ),
    );
  }
}
