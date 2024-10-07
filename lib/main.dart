import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/pilot_bazar-admin.dart';
import 'package:pilot_bazar_admin/mode_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
      WidgetsFlutterBinding.ensureInitialized(); // Make sure Flutter is initialized
  await SharedPreferences.getInstance(); // Initialize SharedPreferences
  runApp(ChangeNotifierProvider(
    create: (context) => ModeProvider(),
    child: PilotBazarAdmin(),
  ));
}
