import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/screens/auth/login_screen.dart';
import 'package:pilot_bazar_admin/screens/auth/otp_verification.dart';
import 'package:pilot_bazar_admin/widget/alert_dialog.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';

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
          Uri.parse('${Urls().baseUrl}merchant/auth/register'),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json'
          },
          body: jsonEncode(body));
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
      } else {
        CustomAlertDialog().showAlertDialog(context, "error", "error");
      }
    } else {
      print("error");
      CustomAlertDialog()
          .showAlertDialog(context, "Please Provide Correct Information", "OK");
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
                SizedBox(height: size.height / 5),
                const Text("Registration"),
                MyTextFromFild(
                  myController: nameController,
                  hintText: "Enter Name",
                  validatorText: "Please Emter Name",
                  keyboardType: TextInputType.text,
                ),
                height10,
                MyTextFromFild(
                  myController: phoneNumberController,
                  hintText: "Enter Phone Number",
                  validatorText: "Please Enter Phone Number",
                  keyboardType: TextInputType.number,
                ),
                height10,
                MyTextFromFild(
                  myController: companyNameController,
                  hintText: "Company Name",
                  validatorText: "Please Company Name",
                  keyboardType: TextInputType.text,
                ),
                height10,
                MyTextFromFild(
                  myController: passwordController,
                  hintText: "Password",
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
                MyTextFromFild(
                  myController: confirmPasswordController,
                  hintText: "Confirm Password",
                  validatorText: "Please Confirm Password",
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
                        style: Theme.of(context).elevatedButtonTheme.style,
                        onPressed: () async {
                          if (!formKey.currentState!.validate()) {
                            return null;
                          }

                          await registration();

                          // Navigator.pushAndRemoveUntil(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             OTPVerificationScreen()),
                          //     (route) => false);
                        },
                        child: const Text("Register"))),
                height10,
                const Text("We Will Send a OTP to your phone number"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "If Already have Account ",
                      style: small14StyleW500,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                              (route) => false);
                        },
                        child: const Text(
                          "Login",
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
