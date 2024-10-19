import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/pilot_bazar-admin.dart';
import 'package:pilot_bazar_admin/provider/mode_provider.dart';
import 'package:pilot_bazar_admin/provider/socket_methode_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
      WidgetsFlutterBinding.ensureInitialized(); // Make sure Flutter is initialized
  await SharedPreferences.getInstance(); // Initialize SharedPreferences
  runApp(
    
MultiProvider(
  providers: [
     ChangeNotifierProvider<ModeProvider>( create: (context) => ModeProvider()),
        ChangeNotifierProvider<SocketMethodProvider>( create: (context) => SocketMethodProvider()),
   
  ],
  child: PilotBazarAdmin(),
));
}
