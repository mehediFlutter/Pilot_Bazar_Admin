import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/screens/auth/registration_screen.dart';

import '../../widget/login_registration_textFild.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
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
              MyTextFromFild(
                myController: nameController,
                hintText: "Enter Name",
                validatorText: "Please Emter Name",
                keyboardType: TextInputType.text,
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
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
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
                      onPressed: () {
                        if (!formKey.currentState!.validate()) {
                          return null;
                        }

                        print(nameController.text);
                        print(passwordController.text);
                        print(companyNameController.text);
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
    ));
  }
}
