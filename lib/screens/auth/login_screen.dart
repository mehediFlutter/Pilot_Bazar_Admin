import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/pilot_bazar-admin.dart';
import 'package:pilot_bazar_admin/screens/auth/auth_utility.dart';
import 'package:pilot_bazar_admin/screens/auth/loain_model.dart';
import 'package:pilot_bazar_admin/screens/auth/registration_screen.dart';
import 'package:pilot_bazar_admin/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

import '../../widget/login_registration_textFild.dart';
import '../../widget/urls.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late bool passwordVisible;
  late SharedPreferences prefss;
  var token;
  var merchantId;
  var merchantName;
  var mobileNumber;

  Future login() async {
    Map<String, dynamic> body = {
      "mobile": phoneNumberController.text,
      "password": passwordController.text, //01407054411
    };
    Response response = await post(
        Uri.parse('${Urls().baseUrl}merchant/auth/login'),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json'
        },
        body: jsonEncode(body));
    print(response.statusCode);
    // print(response.body);
    if (response.statusCode == 200) {
      Map decodedBody = jsonDecode(response.body.toString());
      LoginModel model =
          LoginModel.fromJson(decodedBody.cast<String, dynamic>());
      await AuthUtility.saveUserInfo(model);
      print(model.toJson()['payload']['merchant']['name']);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => PilotBazarAdmin()),
          (route) => false);
    }
  }

  // Future myLogin() async {
  //   prefss = await SharedPreferences.getInstance();

  //   Map<String, dynamic> body = {
  //     "mobile": phoneNumberController.text,
  //     "password": passwordController.text
  //   };
  //   Response response = await post(
  //       Uri.parse('${Urls().baseUrl}api/merchant/auth/login'),
  //       headers: {
  //         'Accept': 'application/vnd.api+json',
  //         'Content-Type': 'application/vnd.api+json'
  //       },
  //       body: jsonEncode(body));
  //   print("status code");
  //   print(response.statusCode);

  //   if (response.statusCode == 200) {
  //     Map decodedBody = jsonDecode(response.body.toString());
  //     print(decodedBody);
  //     token = decodedBody['payload']?['token']!;
  //     merchantId = decodedBody['payload']?['merchant']?['id'];
  //     merchantName = decodedBody['payload']?['merchant']?['merchant_info']
  //             ?['company_name'] ??
  //         decodedBody['payload']?['merchant']['name'];
  //     mobileNumber = decodedBody['payload']?['merchant']?['mobile'];
  //     LoginModel model =
  //         LoginModel.fromJson(decodedBody.cast<String, dynamic>());
  //     await AuthUtility.saveUserInfo(model);
  //     print(decodedBody['payload']?['token']);

  //     print(token);
  //     await prefss.setString('token', token);
  //     await prefss.setString('merchantId', merchantId.toString());
  //     await prefss.setString('merchantName', merchantName.toString());
  //     await prefss.setString('mobileNumber', mobileNumber.toString());
  //     setState(() {});
  //     print(model.payload!.token);
  //     await prefss.setBool('isLogin', true);

  //     print("Login Success");
  //   }

  //   if (response.statusCode == 200) {
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(builder: (context) => BottomNavBaseScreen()),
  //         (route) => false);
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text("Error Phone number or Password try again!!!")));
  //   }
  // }

  @override
  void initState() {
    passwordVisible = false;
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
                SizedBox(height: size.height / 3),
                MyTextFromFild(
                  myController: phoneNumberController,
                  hintText: "Enter Phonr Number",
                  validatorText: "Please Emter Phone number",
                  keyboardType: TextInputType.number,
                ),
                height10,
                MyTextFromFild(
                  myController: passwordController,
                  hintText: "Enter Password",
                  validatorText: "Please Enter Password",
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
                        style: Theme.of(context).elevatedButtonTheme.style,
                        onPressed: () async {
                          if (!formKey.currentState!.validate()) {
                            return null;
                          }

                          print(phoneNumberController.text);
                          print(passwordController.text);
                          await login();
                        },
                        child: const Text("Login"))),
                height10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't Have an account ?",
                      style: small14StyleW500,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationScreen()),
                              (route) => false);
                        },
                        child: Text(
                          "Registration",
                          style: small14StyleW600,
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
