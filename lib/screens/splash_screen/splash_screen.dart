import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_listTile.dart';
import 'package:pilot_bazar_admin/pilot_bazar-admin.dart';
import 'package:pilot_bazar_admin/screens/auth/auth_utility.dart';
import 'package:pilot_bazar_admin/screens/auth/loain_model.dart';
import 'package:pilot_bazar_admin/screens/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SplashScreen extends StatefulWidget {
  final ValueNotifier<ThemeMode> notifier;
  const SplashScreen({Key? key, required this.notifier}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool isDoubleScreenSelected;
  // late String mToken;
  var isDeviceConnected = false;
  var isAlertSet = false;
  var userInfo;

  loadUserInfo() async {
    LoginModel user = await AuthUtility.getUserInfo();
    userInfo = user.toJson();
    setState(() {});
    print(userInfo);
    print(userInfo['payload']['merchant']['name'].toString());
  }

  @override
  void initState() {
    super.initState();
    //  loadSelectedScreenType();
    loadUserInfo();
    navigateToLoginOrHome();
  }

  @override
  Future<void> navigateToLoginOrHome() async {
    setState(() {});
    print("Is login");

    Future.delayed(const Duration(seconds: 1)).then(
      (_) => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => (userInfo != null)
                  ? CustomerOverView(
                      notifier: widget.notifier,
                    )
                  : LoginScreen()),
          (route) => false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "PilotBazar.com",
              style: TextStyle(color: Colors.black87, fontSize: 20),
            ),
          ),
          Center(
            child: Text(
              " Do Business with us",
              style: TextStyle(color: Colors.black87, fontSize: 20),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 200,
              ),
              // Spacer(),
              SpinKitSpinningLines(
                color: Colors.black,
                size: 60.0,
              ),
            ],
          ),
        ],
      ),
    );
  }

  showDialogBox() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(
                child: Text(
              'No Internet Connection',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            )),
            content: const Text(
              "Please Check your internet connectivity",
              style: TextStyle(color: Colors.black87, fontSize: 12),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    isAlertSet = false;
                    isDeviceConnected =
                        await InternetConnectionChecker().hasConnection;
                    if (!isDeviceConnected) {
                      showDialogBox();

                      isAlertSet = true;
                      setState(() {});
                    }
                  },
                  child: const Center(
                      child: Text(
                    "OK",
                    style: TextStyle(fontSize: 17),
                  )))
            ],
          );
        });
  }
}
