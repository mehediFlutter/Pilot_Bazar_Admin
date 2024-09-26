import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/pilot_bazar-admin.dart';
import 'package:pilot_bazar_admin/theme_manager.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ModeProvider(),
    child: PilotBazarAdmin(),
  ));
}
