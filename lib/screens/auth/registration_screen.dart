import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/network_service/network_caller.dart';
import 'package:pilot_bazar_admin/network_service/network_response.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_over_view.dart';
import 'package:pilot_bazar_admin/screens/auth/auth_utility.dart';
import 'package:pilot_bazar_admin/screens/auth/loain_model.dart';
import 'package:pilot_bazar_admin/screens/auth/login_screen.dart';
import 'package:pilot_bazar_admin/screens/auth/otp_verification.dart';
import 'package:pilot_bazar_admin/screens/auth/token.dart';
import 'package:pilot_bazar_admin/widget/alert_dialog.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widget/login_registration_textFild.dart';

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

  Future registration() async {
    Map<String, dynamic> body = {
      "name": nameController.text,
      "company_name": companyNameController.text,
      "mobile": phoneNumberController.text,
      "password": passwordController.text,
      "password_confirmation": confirmPasswordController.text,
    };
    if (passwordController.text == confirmPasswordController.text) {
      Response response = await post(
          Uri.parse('${baseUrlWithAPI_EndPoint}merchant/auth/register'),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json'
          },
          body: jsonEncode(body));
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        newlyRegistraterdWithLogin();
      } else {
        CustomAlertDialog()
            .showAlertDialog(context, "Fill the Filds Properly ", "OK");
      }
    } else {
      print("error");
      CustomAlertDialog()
          .showAlertDialog(context, "Please Provide Correct Information", "OK");
    }
  }

  newlyRegistraterdWithLogin() async {
    NetworkResponse response = await NetworkCaller().newlyRegisterLogin(
        '${baseUrlWithAPI_EndPoint}merchant/auth/login', <String, dynamic>{
      "mobile": phoneNumberController.text,
      "password": passwordController.text,
    });
    if (response.isSuccess) {
      LoginModel model = LoginModel.fromJson(response.body!);
      await AuthUtility.saveUserInfo(model);
      print("Registred login body");
      print(model.toJson()['payload'].toString());
      print(model.toJson()['payload']['merchant']['name'].toString());
      await AuthToken().saveToken(model.toJson()['payload']['token']);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => CustomerOverView()),
          (route) => false);
    } else {
      CustomAlertDialog()
          .showAlertDialog(context, "Some thing error Try Agein", "OK");
    }
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
                //  height10,
                //    const Text("Registration"),
                MyTextFromFild(
                  myController: nameController,
                  hintText: "Enter Name",
                  validatorText: "Please Emter Name",
                  keyboardType: TextInputType.text,
                  prefixIcon: Image.asset('assets/icons/person_icon.png'),
                ),
                height10,
                MyTextFromFild(
                  myController: phoneNumberController,
                  hintText: "Enter Phone Number",
                  validatorText: "Please Enter Phone Number",
                  prefixIcon: Image.asset('assets/icons/phone_icon.png'),
                  keyboardType: TextInputType.number,
                ),
                height10,
                MyTextFromFild(
                  myController: companyNameController,
                  hintText: "Company Name",
                  validatorText: "Please Company Name",
                  prefixIcon: Image.asset('assets/icons/company_icon.png'),
                  keyboardType: TextInputType.text,
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
                MyTextFromFild(
                  myController: confirmPasswordController,
                  hintText: "Confirm Password",
                  validatorText: "Please Confirm Password",
                  prefixIcon: Image.asset('assets/icons/password_icon.png'),
                  keyboardType: TextInputType.text,
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
                          if (!formKey.currentState!.validate()) {
                            return null;
                          }

                          await registration();
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(fontSize: 25),
                        ))),
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
