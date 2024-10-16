import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/screens/auth/auth_utility.dart';
import 'package:pilot_bazar_admin/screens/auth/loain_model.dart';
import 'package:pilot_bazar_admin/screens/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:pilot_bazar_admin/widget/alert_dialog.dart';
import 'package:pilot_bazar_admin/widget/text_filds/text_filds_for_password.dart';
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
  TextEditingController demoController = TextEditingController();
  late bool passwordVisible;
  late SharedPreferences prefss;
  String? token;
  String? authUserID;
  var merchantId;
  var merchantName;
  var mobileNumber;
  initSharedPref() async {
    prefss = await SharedPreferences.getInstance();
  }

  bool loginInProgress = false;


  Future login() async {
    loginInProgress = true;
    if (mounted) {
      setState(() {});
    }
    prefss = await SharedPreferences.getInstance();
    Map<String, dynamic> body = {
      "phone": phoneNumberController.text,
      "password": passwordController.text, //01407054411
    };
    Response response = await post(
        Uri.parse('${APP_APISERVER_URL}/api/merchant/auth/login'),
        headers: globalHeader,
        body: jsonEncode(body));

    Map decodedBody = jsonDecode(response.body.toString());
    print("Login Body is : $decodedBody");

    if (response.statusCode == 200) {
      Map decodedBody = jsonDecode(response.body.toString());

      LoginModel model =
          LoginModel.fromJson(decodedBody.cast<String, dynamic>());
      await AuthUtility.saveUserInfo(model);
      token = model.toJson()['payload']['token'];
      authUserID = model.toJson()['payload']['user']['id'];
      await prefss.setString('token', token ?? '');
      await prefss.setString('authUserID', authUserID ?? '');
      loginInProgress = false;
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
                  hintText: "Phone Number",
                  validatorText: "Enter Phone number",
                  prefixIcon: Image.asset('assets/icons/phone_icon.png'),
                  keyboardType: TextInputType.number,
                ),
                height10,
                
                TextFieldForPassword(
                  myController: passwordController,
                  hintText: 'Password',
                  validatorText: 'Enter Password',
                   prefixIcon: Image.asset('assets/icons/password_icon.png'),
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
                    child: loginInProgress
                        ? Center(
                            child: CircularProgressIndicator(
                            color: Color(0xFF0386D0),
                          ))
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0386D0),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            //  style: Theme.of(context).elevatedButtonTheme.style,
                            onPressed: () async {
                              print("Phone number ${phoneNumberController.text}");
                              print("Password ${passwordController.text}");
                              if (!formKey.currentState!.validate()) {
                                return null;
                              }

                              await login();
                            },
                            child: const Text(
                              "Login",
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ))),
                SizedBox(height: size.height / 8),
                Text(
                  "By Sharing in your Agreeing our",
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

Map<String, String> globalHeader = {
  'Accept': 'application/json',
  'Content-Type': 'application/json'
};

Map<String, String> uploadHeader = {
  'Accept': 'application/json',
  'Content-Type': 'multipart/form-data',
};
