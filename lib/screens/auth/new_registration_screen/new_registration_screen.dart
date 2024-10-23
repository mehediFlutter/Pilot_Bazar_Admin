import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/screens/auth/auth_utility.dart';
import 'package:pilot_bazar_admin/screens/auth/loain_model.dart';
import 'package:pilot_bazar_admin/screens/auth/login_screen.dart';
import 'package:pilot_bazar_admin/screens/auth/new_registration_screen/Login_text_fild_upper_text.dart';
import 'package:pilot_bazar_admin/screens/auth/new_registration_screen/text_form_field.dart';
import 'package:pilot_bazar_admin/screens/auth/new_text_fildes/new_name_text_fild.dart';
import 'package:pilot_bazar_admin/screens/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:pilot_bazar_admin/widget/alert_dialog.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewRegistrationScreen extends StatefulWidget {
  NewRegistrationScreen({super.key});

  @override
  State<NewRegistrationScreen> createState() => _NewRegistrationScreenState();
}

class _NewRegistrationScreenState extends State<NewRegistrationScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController namerController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  late bool passwordVisible;
  late bool confirmPasswordVisible;

  bool isRegistrationInProgress = false;
  late SharedPreferences preferences;
  String? token;
  String? authUserID;

  Future registration() async {
    preferences = await SharedPreferences.getInstance();
    isRegistrationInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> body = {
      "name": namerController.text,
      "mobile": phoneNumberController.text,
      // "company_name"            : companyNameController.text,
      "password": passwordController.text,
      "password_confirmation": confirmPasswordController.text,
    };
    if (passwordController.text == confirmPasswordController.text) {
      Response response = await post(
          Uri.parse('$APP_APISERVER_URL/api/v1/vendor-management/register'),
          headers: globalHeader,
          body: jsonEncode(body));

      Map decodedBody = jsonDecode(response.body.toString());
      print(response.body);
      if (response.statusCode == 200) {
        LoginModel model =
            LoginModel.fromJson(decodedBody.cast<String, dynamic>());
        await AuthUtility.saveUserInfo(model);
        token = model.toJson()['token'];
        authUserID = model.toJson()['id'];

        await preferences.setString('token', token ?? '');
        await preferences.setString('authUserID', authUserID ?? '');

        isRegistrationInProgress = false;
        if (mounted) {
          setState(() {});
        }
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavBaseScreen()),
            (route) => false);
      } else {
        isRegistrationInProgress = false;
        if (mounted) {
          setState(() {});
        }
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

  @override
  void initState() {
    passwordVisible = false;
    confirmPasswordVisible = false;
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldUpperText(
                text: 'Phone Number',
              ),
              NewPhoneNumberTextFormField(
                textEditingController: phoneNumberController,
                hintText: 'Enter Your Phone Number',
                validatorText: 'Enter Phone Number',
              ),
              TextFieldUpperText(
                text: 'Name',
              ),
              NewNameTextFormField(
                textEditingController: namerController,
                hintText: 'Enter Your Name',
                validatorText: 'Enter Name',
              ),
              TextFieldUpperText(
                text: 'Company Name',
              ),
              NewNameTextFormField(
                textEditingController: companyNameController,
                hintText: 'Enter Your Company Name',
                validatorText: 'Enter Company Name',
              ),
              TextFieldUpperText(
                text: 'Enter Password',
              ),
              NewPasswordTextFormField(
                textEditingController: passwordController,
                hintText: 'Enter Password',
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
              TextFieldUpperText(
                text: 'Confirm Password',
              ),
              NewPasswordTextFormField(
                textEditingController: confirmPasswordController,
                obscureText: !confirmPasswordVisible,
                hintText: 'Confirm Password',
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
              height20,
              Container(
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
                      await registration();
                    },
                    child: Text(
                      "Registration",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
