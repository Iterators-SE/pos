import 'package:flutter/material.dart';

import 'xpos_theme.dart';

XPosTheme currentTheme = XPosTheme();

Map<int, Color> _color = {
  50: Color.fromRGBO(80,146,163, 1),
  100: Color.fromRGBO(24, 92, 55, .2),
  200: Color.fromRGBO(24, 92, 55, .3),
  300: Color.fromRGBO(24, 92, 55, .4),
  400: Color.fromRGBO(24, 92, 55, .5),
  500: Color.fromRGBO(171,212,219, 1),
  600: Color.fromRGBO(24, 92, 55, .7),
  700: Color.fromRGBO(24, 92, 55, .8),
  800: Color.fromRGBO(24, 92, 55, .9),
  900: Color.fromRGBO(24, 92, 55, 1),
};

MaterialColor xposGreen = MaterialColor(0xFF6BA4BC, _color);
