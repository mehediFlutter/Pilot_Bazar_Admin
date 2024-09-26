import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    surface: Colors.white,
    onSurface: Color(0xFFEEEEEE),
    primary: Colors.white,
    secondary: Colors.black,
  ),
);

ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    surface: Colors.green,
    onSurface: Colors.blue,
    primary: Colors.black,
    //  secondary: Colors.black,
  ),
);
