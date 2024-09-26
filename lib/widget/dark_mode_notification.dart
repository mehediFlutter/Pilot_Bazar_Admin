import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  final bool _isDark = false;
  bool get isDark => _isDark;
}
