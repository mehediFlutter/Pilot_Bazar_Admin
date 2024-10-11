import 'package:flutter/material.dart';

const Color appColor = Color(0xFF666666);
const Color searchBarBorderColor = Color(0xFFEEEEEE);
const Color syncIconColor = Color(0xFFDDDDDD);
const Color dropdownIconColor = Color(0xFF666666);
const Color whiteColor = Color.fromRGBO(255, 255, 255, 1);
const Color allCustomerBorderAndTextColor = Color(0xFF1FB9FC);
const Color inActiveDrawerItemIconColor = Color(0xFF666666);
const Color activeDrawerItemIconColor = Colors.blue;

BorderRadius borderRadious10 = BorderRadius.circular(10);
BorderRadius borderRadious8 = BorderRadius.circular(10);

OutlineInputBorder searchBarBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(color: searchBarBorderColor));

const TextStyle small10Style =
    TextStyle(fontSize: 10, fontFamily: 'Inter', color: Colors.black);
const TextStyle small10Stylew500 = TextStyle(
    fontSize: 10,
    fontFamily: 'Inter',
    color: Colors.black,
    fontWeight: FontWeight.w500);
const TextStyle small12Stylew500 = TextStyle(
    fontSize: 12,
    fontFamily: 'Inter',
    color: Colors.black,
    fontWeight: FontWeight.w500);

const TextStyle small12Stylew400 = TextStyle(
    fontSize: 12,
    fontFamily: 'Inter',
    color: Colors.black,
    fontWeight: FontWeight.w400);

const TextStyle small14StyleW500 = TextStyle(
    fontSize: 14,
    fontFamily: 'Inter',
    color: Colors.black,
    fontWeight: FontWeight.w500);

const TextStyle small14StyleW600 = TextStyle(
    fontSize: 14,
    fontFamily: 'Inter',
    color: Colors.black,
    fontWeight: FontWeight.w600);
const TextStyle small16StyleW600 = TextStyle(
    fontSize: 16,
    fontFamily: 'Inter',
    color: Colors.black,
    fontWeight: FontWeight.w600);

const TextStyle loginRegistrationHintTextStyle = TextStyle(
  fontSize: 14,
  fontFamily: 'Inter',
  color: Colors.black,
);

TextStyle activedDrawerItem = const TextStyle(
  fontSize: 14,
  fontFamily: 'Inter',
  color: Colors.blue,
  fontWeight: FontWeight.w500,
);
TextStyle inActivedDrawerItem = const TextStyle(
  fontSize: 14,
  fontFamily: 'Inter',
  color: inActiveDrawerItemIconColor,
  fontWeight: FontWeight.w500,
);
TextStyle fontSize14 = const TextStyle(
  fontSize: 14,
  fontFamily: 'Inter',
  color: Color(0xFF444444),
  fontWeight: FontWeight.w500,
);
TextStyle fontSize12FW400 = const TextStyle(
  fontSize: 12,
  fontFamily: 'Inter',
  color: Color(0xFF444444),
  fontWeight: FontWeight.w400,
);

TextStyle registrationR = const TextStyle(
  color: Colors.white,
  fontSize: 13,
);

Container dariContainer = Container(
  height: 20,
  width: 2,
  decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
);
