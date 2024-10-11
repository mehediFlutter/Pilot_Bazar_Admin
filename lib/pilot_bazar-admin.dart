import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/screens/auth/auth_utility.dart';
import 'package:pilot_bazar_admin/screens/auth/loain_model.dart';
import 'package:pilot_bazar_admin/screens/splash_screen/splash_screen.dart';
import 'package:pilot_bazar_admin/theme/theme.dart';
import 'package:pilot_bazar_admin/provider/mode_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PilotBazarAdmin extends StatefulWidget {
  final ValueNotifier<ThemeMode> notifier = ValueNotifier(ThemeMode.light);

  PilotBazarAdmin({super.key});

  @override
  _PilotBazarAdminState createState() => _PilotBazarAdminState();
}

class _PilotBazarAdminState extends State<PilotBazarAdmin> {
  late SharedPreferences preffs;
  var userInfo;

  loadUserInfo() async {
    LoginModel user = await AuthUtility.getUserInfo();
    userInfo = user.toJson();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initSharedPrefs();
    loadUserInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  themeListner() {
    if (mounted) {
      setState(() {});
    }
  }

  initSharedPrefs() async {
    preffs = await SharedPreferences.getInstance();
    setState(() {});
    if (preffs.containsKey('notifier')) {
 
      widget.notifier.value = (preffs.getString('notifier') == 'ThemeMode.dark')
          ? ThemeMode.light
          : ThemeMode.dark;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.notifier,
      builder: (_, mode, __) {

        return MaterialApp(
          themeMode: Provider.of<ModeProvider>(context).lightModeEnable
              ? ThemeMode.light
              : ThemeMode.dark,
          theme: lightTheme,
          darkTheme: darkTheme,
          debugShowCheckedModeBanner: false,
          home:

              // ShimmarEffectForSingleVehicle(
              //   isShareOptio: true,
              // )

              SplashScreen(
            notifier: widget.notifier,
          ),
        );
      },
    );
  }
}
