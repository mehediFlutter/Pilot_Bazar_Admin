import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    surface: Colors.white,
    //  onSurface: Color(0xFFEEEEEE),
    primary: Colors.black,
    secondary: Colors.grey,
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusColor: Colors.black)),
  // elevatedButtonTheme: ElevatedButtonThemeData(
  //     style: ElevatedButton.styleFrom(backgroundColor: Colors.grey)),

  // inputDecorationTheme: InputDecorationTheme(
  //   border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))

  // inputDecorationTheme: InputDecorationTheme(
  //   hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
  //   border: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(10),
  //     borderSide: BorderSide(color: const Color.fromARGB(255, 228, 222, 222)),
  //   ),
  //   focusedBorder: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(10),
  //     borderSide: BorderSide(color: Colors.grey),
  //     // You can change the color as needed
  //   ),
  //   errorBorder: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(10),
  //     borderSide: BorderSide(color: Colors.red),
  //   ),
  // ),
);

ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    surface: Colors.grey,
    onSurface: Colors.blue,
    primary: Colors.black,
    secondary: Colors.grey,

    //  secondary: Colors.black,
  ),
);
