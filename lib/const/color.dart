import 'dart:ui';
import 'package:flutter/material.dart';

const Color appColor = Color(0xFF666666);
const Color searchBarBorderColor = Color(0xFFEEEEEE);
const Color whiteColor = Colors.white;

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
const TextStyle small12Style = TextStyle(
    fontSize: 12,
    fontFamily: 'Inter',
    color: Colors.black,
    fontWeight: FontWeight.w500);
