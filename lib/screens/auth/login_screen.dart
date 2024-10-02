import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_over_view.dart';
import 'package:pilot_bazar_admin/screens/auth/auth_utility.dart';
import 'package:pilot_bazar_admin/screens/auth/loain_model.dart';
import 'package:pilot_bazar_admin/screens/auth/registration_screen.dart';
import 'package:pilot_bazar_admin/screens/single_vehicle_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

import '../../widget/login_registration_textFild.dart';
import '../../widget/urls.dart';

class LoginScreen extends StatefulWidget {
  final ValueNotifier<ThemeMode> notifier = ValueNotifier(ThemeMode.light);
  final bool isNewRegistrated;
  final String? phoneNUmber;
  final String? password;

  LoginScreen(
      {super.key,
      this.isNewRegistrated = false,
      this.phoneNUmber,
      this.password});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late bool passwordVisible;
  late SharedPreferences prefss;
  String? token;
  var merchantId;
  var merchantName;
  var mobileNumber;
  initSharedPref() async {
    prefss = await SharedPreferences.getInstance();
  }

  Future login() async {
    prefss = await SharedPreferences.getInstance();
    Map<String, dynamic> body = {
      "mobile": phoneNumberController.text,
      "password": passwordController.text, //01407054411
    };
    Response response = await post(
        Uri.parse('${baseUrlWithAPI_EndPoint}merchant/auth/login'),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json'
        },
        body: jsonEncode(body));
    print(response.statusCode);
    if (response.statusCode == 200) {
      Map decodedBody = jsonDecode(response.body.toString());

      LoginModel model =
          LoginModel.fromJson(decodedBody.cast<String, dynamic>());
      await AuthUtility.saveUserInfo(model);
      print(model.toJson()['payload']['merchant']['name']);
      token = model.toJson()['payload']['token'];
      print(token);
      await prefss.setString('token', token ?? '');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SingleVehicleScreen()),
          (route) => false);
    }
  }

  var userInfo;
  loadUserInfo() async {
    LoginModel user = await AuthUtility.getUserInfo();
    userInfo = user.toJson();
  }

  @override
  void initState() {
    passwordVisible = false;
    loadUserInfo();
    initSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                height20,

                MyTextFromFild(
                  myController: phoneNumberController,
                  hintText: "Phonr Number",
                  validatorText: "Please Emter Phone number",
                  prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Image.asset('assets/icons/phone_icon.png')),
                  keyboardType: TextInputType.number,
                ),
                height10,
                MyTextFromFild(
                  myController: passwordController,
                  hintText: "Password",
                  validatorText: "Please Enter Password",
                  prefixIcon: Image.asset('assets/icons/password_icon.png'),
                  keyboardType: TextInputType.text,
                  obscureText: !passwordVisible,
                  icon: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey.shade800,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      }),
                ),
                height10,
                height30,
                SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF0386D0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        //  style: Theme.of(context).elevatedButtonTheme.style,
                        onPressed: () async {
                          if (!formKey.currentState!.validate()) {
                            return null;
                          }

                          print(phoneNumberController.text);
                          print(passwordController.text);
                          await login();
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 25),
                        ))),
                height40,
                height40,
                height40,
                Text(
                  "By Sharing in your agreeing our",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Term and privacy policy",
                  style: TextStyle(color: Colors.blue, fontSize: 18),
                ),
                Image.asset('assets/icons/login_page_down_icon.png'),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     // Text(
                //     //   "Don't Have an account ?",
                //     //   style: small14StyleW500,
                //     // ),
                //     // TextButton(
                //     //     onPressed: () {
                //     //       Navigator.pushAndRemoveUntil(
                //     //           context,
                //     //           MaterialPageRoute(
                //     //               builder: (context) => RegistrationScreen()),
                //     //           (route) => false);
                //     //     },
                //     //     child: Text(
                //     //       "Registration",
                //     //       style: small14StyleW600,
                //     //     ))
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
