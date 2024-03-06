import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier{
  bool _isDark = false;
  bool get isDark=>_isDark;
}