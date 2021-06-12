import 'package:flutter/material.dart';

import 'xpos_theme.dart';

XPosTheme currentTheme = XPosTheme();

Map<int, Color> _color = {
  10: Color.fromRGBO(194,222,228, .8),
  50: Color.fromRGBO(194,222,228, 1),
  100: Color.fromRGBO(150,195,204, 1),
  200: Color.fromRGBO(80,146,163, .8),
  300: Color.fromRGBO(80,146,163, 1),
  400: Color.fromRGBO(118,181,197, 1),
  500: Color.fromRGBO(171,212,219, 1),
  600: Color.fromRGBO(150, 199, 209, 1),
  700: Color.fromRGBO(24, 92, 55, .8),
  800: Color.fromRGBO(24, 92, 55, .9),
  900: Color.fromRGBO(180,204,213, 1),
};

MaterialColor xposGreen = MaterialColor(0xFF6BA4BC, _color);
