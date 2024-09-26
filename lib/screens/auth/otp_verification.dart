import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/screens/auth/login_screen.dart';
import 'package:pilot_bazar_admin/screens/auth/registration_screen.dart';

import '../../widget/login_registration_textFild.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController phoneNumberController = TextEditingController();

  late bool passwordVisible;
  @override
  void initState() {
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("OTP Verification"),
              height20,
              MyTextFromFild(
                myController: phoneNumberController,
                hintText: "Enter OTP",
                validatorText: "Please Emter OTP",
                keyboardType: TextInputType.text,
              ),
              height40,
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      style: Theme.of(context).elevatedButtonTheme.style,
                      onPressed: () {
                        if (!formKey.currentState!.validate()) {
                          return null;
                        }
                      },
                      child: const Text("Confirm OTP"))),
              height10,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already Have an Account ?",
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
                      child: Text(
                        "Login",
                        style: small14StyleW600,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
