import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/network_service/network_caller.dart';
import 'package:pilot_bazar_admin/network_service/network_response.dart';
import 'package:pilot_bazar_admin/screens/auth/auth_utility.dart';
import 'package:pilot_bazar_admin/screens/auth/loain_model.dart';
import 'package:pilot_bazar_admin/screens/auth/login_screen.dart';
import 'package:pilot_bazar_admin/screens/auth/token.dart';
import 'package:pilot_bazar_admin/screens/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:pilot_bazar_admin/widget/alert_dialog.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widget/login_registration_textFild.dart';
import '../../widget/text_filds/name_text_fild.dart';
import '../../widget/text_filds/text_filds_for_password.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  late bool passwordVisible;
  late bool confirmPasswordVisible;
  bool isRegistrationInProgress = false;

  Future registration() async {
    isRegistrationInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> body = {
      "name": nameController.text,
      "phone": phoneNumberController.text,
      // "company_name": companyNameController.text,

      "password": passwordController.text,
      "password_confirmation": confirmPasswordController.text,
    };
    if (passwordController.text == confirmPasswordController.text) {
      Response response = await post(
          Uri.parse('$APP_APISERVER_URL/api/merchant/auth/register'),
          headers: globalHeader,
          body: jsonEncode(body));


      Map decodedBody = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        newlyRegistraterdWithLogin();
      } else {
        CustomAlertDialog().showAlertDialog(
          context,
          decodedBody['message'] + ' Please Try Again'.toString(),
          "OK",
        );
      }
    } else {
      isRegistrationInProgress = false;
      if (mounted) {
        setState(() {});
      }
      print("error");
      CustomAlertDialog()
          .showAlertDialog(context, "Please Provide Correct Information", "OK");
    }
    isRegistrationInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  String? token;
  String? authUserID;

  newlyRegistraterdWithLogin() async {
    SharedPreferences prefss = await SharedPreferences.getInstance();
    NetworkResponse response = await NetworkCaller().newlyRegisterLogin(
        '$APP_APISERVER_URL/api/merchant/auth/login', <String, dynamic>{
      "phone": phoneNumberController.text,
      "password": passwordController.text,
    });

    if (response.isSuccess) {
      LoginModel model = LoginModel.fromJson(response.body!);
      await AuthUtility.saveUserInfo(model);

      token = model.toJson()['payload']['token'];
      authUserID = model.toJson()['payload']['user']['id'];
      await prefss.setString('token', token ?? '');
      await prefss.setString('authUserID', authUserID ?? '');


      await AuthToken().saveToken(model.toJson()['payload']['token']);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBaseScreen()),
          (route) => false);
    } else {
      isRegistrationInProgress = true;
      setState(() {});
      CustomAlertDialog().showAlertDialog(
        context,
        "Something wrong" + ' Please Try Again'.toString(),
        "OK",
      );
    }
    isRegistrationInProgress = false;
    setState(() {});
  }

  @override
  void initState() {
    passwordVisible = false;
    confirmPasswordVisible = false;
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
                height10,

                TextFieldForName(
                  hintText: 'Enter Name',
                  validatorText: 'Enter Name',
                  myController: nameController,
                  prefixIcon: Image.asset('assets/icons/person_icon.png'),
                ),

                height10,
                MyTextFromFild(
                  myController: phoneNumberController,
                  hintText: "Enter Phone Number",
                  validatorText: "Enter Phone Number",
                  prefixIcon: Image.asset('assets/icons/phone_icon.png'),
                  keyboardType: TextInputType.number,
                ),
                height10,

                TextFieldForName(
                  hintText: 'Company Name',
                  validatorText: 'Enter Company Name',
                  myController: companyNameController,
                  prefixIcon: Image.asset('assets/icons/company_icon.png'),
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
                TextFieldForPassword(
                  myController: confirmPasswordController,
                  hintText: 'Confirm Password',
                  validatorText: 'Enter Password',
                  prefixIcon: Image.asset('assets/icons/password_icon.png'),
                  obscureText: !confirmPasswordVisible,
                  icon: IconButton(
                      icon: Icon(
                        confirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey.shade800,
                      ),
                      onPressed: () {
                        setState(() {
                          confirmPasswordVisible = !confirmPasswordVisible;
                        });
                      }),
                ),
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
                        onPressed: () async {
                          print("Name ${nameController.text}");
                          print("Phone number ${phoneNumberController.text}");
                          print("Company Name ${companyNameController.text}");
                          print("Password  ${passwordController.text}");
                          print(
                              "Confirm password ${confirmPasswordController.text}");
                          if (!formKey.currentState!.validate()) {
                            return null;
                          }

                          await registration();
                        },
                        child: isRegistrationInProgress
                            ? Center(
                                child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                            : const Text(
                                "Register",
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ))),
                SizedBox(height: size.height / 13),

                Text(
                  "By Clicking Register agreeing our",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Term and privacy policy",
                  style: TextStyle(color: Colors.blue, fontSize: 18),
                ),
                Image.asset('assets/icons/login_page_down_icon.png'),
                //  const Text("We Will Send a OTP to your phone number"),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Text(
                //       "If Already have Account ",
                //       style: small14StyleW500,
                //     ),
                //     TextButton(
                //         onPressed: () {
                //           Navigator.pushAndRemoveUntil(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) => LoginScreen()),
                //               (route) => false);
                //         },
                //         child: const Text(
                //           "Login",
                //           style: small14StyleW600,
                //         ))
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
