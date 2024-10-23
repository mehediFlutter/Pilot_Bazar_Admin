import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/screens/auth/auth_utility.dart';
import 'package:pilot_bazar_admin/screens/auth/loain_model.dart';
import 'package:pilot_bazar_admin/screens/auth/login_screen.dart';
import 'package:pilot_bazar_admin/screens/auth/new_registration_screen/new_registration_screen.dart';
import 'package:pilot_bazar_admin/screens/auth/new_registration_screen/text_fild_upper_text.dart';
import 'package:pilot_bazar_admin/screens/auth/new_text_fildes/new_password_text_fild.dart';
import 'package:pilot_bazar_admin/screens/auth/new_text_fildes/new_phone_number_text_fild.dart';
import 'package:pilot_bazar_admin/screens/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:pilot_bazar_admin/socket_io/tokens.dart';
import 'package:pilot_bazar_admin/widget/alert_dialog.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewLoginScreen extends StatefulWidget {
  const NewLoginScreen({super.key});

  @override
  State<NewLoginScreen> createState() => _NewLoginScreenState();
}

class _NewLoginScreenState extends State<NewLoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late bool passwordVisible;
  @override
  void initState() {
    passwordVisible = false;
  }

  late SharedPreferences preference;

  String? authUserID;
  var merchantId;
  var merchantName;
  var mobileNumber;
  initSharedPref() async {
    preference = await SharedPreferences.getInstance();
  }

  bool loginInProgress = false;

  Future login() async {
    loginInProgress = true;
    if (mounted) {
      setState(() {});
    }
    preference = await SharedPreferences.getInstance();
    Map<String, dynamic> body = {
      "mobile": phoneNumberController.text,
      "password": passwordController.text, //01407054411
    };
    Response response = await post(
        Uri.parse('${APP_APISERVER_URL}/api/v1/vendor-management/login'),
        headers: globalHeader,
        body: jsonEncode(body));

    Map decodedBody = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      Map decodedBody = jsonDecode(response.body.toString());
      print("Login Decoded Body : ${decodedBody}");

      LoginModel model =
          LoginModel.fromJson(decodedBody.cast<String, dynamic>());
      await AuthUtility.saveUserInfo(model);

      String token = decodedBody['token'];
      print("token is from login : ${decodedBody['token']}");
      loginToken = decodedBody['token'];
      authUserID = decodedBody['id'];
      await preference.setString('token',
          decodedBody['token'] ?? token ?? loginToken ?? decodedBody['token']);
      print("Image name: ${decodedBody['image']}");
      print("ID after image: ${decodedBody['id']}");
      await preference.setString('authUserID', authUserID ?? '');
      await preference.setString('image', decodedBody['image']);
      if (mounted) {
        setState(() {});
      }
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBaseScreen()),
          (route) => false);
    } else {
      loginInProgress = false;
      setState(() {});

      CustomAlertDialog().showAlertDialog(
        context,
        decodedBody['message'] + ' Please Try Again'.toString(),
        "OK",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
        child: Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    "Log In",
                    style: TextStyle(fontSize: 36, color: Colors.black),
                  )),
                  height12,
                  TextFieldUpperText(
                    text: 'Phone Number',
                  ),
                  NewPhoneNumberTextFormField(
                    textEditingController: phoneNumberController,
                    hintText: 'Enter Your Phone Number',
                    validatorText: 'Enter Phone Number',
                  ),
                  TextFieldUpperText(
                    text: 'Password',
                  ),
                  NewPasswordTextFormField(
                    validatorText: 'Enter Password',
                    textEditingController: passwordController,
                    obscureText: !passwordVisible,
                    hintText: 'Enter Password',
                    icon: IconButton(
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey.shade800,
                        ),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        }),
                  ),
                  height20,
                  loginInProgress
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        )
                      : Container(
                          height: 44,
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () async {
                                if (!formKey.currentState!.validate()) {
                                  return null;
                                }

                                await login();
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )),
                        ),
                  height30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      width5,
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NewRegistrationScreen()),
                              (route) => false);
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
