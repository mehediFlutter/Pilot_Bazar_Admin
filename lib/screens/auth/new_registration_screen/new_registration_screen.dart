import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/screens/auth/auth_utility.dart';
import 'package:pilot_bazar_admin/screens/auth/loain_model.dart';
import 'package:pilot_bazar_admin/screens/auth/login_screen.dart';
import 'package:pilot_bazar_admin/screens/auth/new_login_screen/new_login_screen.dart';
import 'package:pilot_bazar_admin/screens/auth/new_registration_screen/text_fild_upper_text.dart';
import 'package:pilot_bazar_admin/screens/auth/new_text_fildes/new_name_text_fild.dart';
import 'package:pilot_bazar_admin/screens/auth/new_text_fildes/new_password_text_fild.dart';
import 'package:pilot_bazar_admin/screens/auth/new_text_fildes/new_phone_number_text_fild.dart';
import 'package:pilot_bazar_admin/screens/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:pilot_bazar_admin/socket_io/tokens.dart';
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
      "company": companyNameController.text,
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
        Map decodedBody = jsonDecode(response.body.toString());
        print("Login Decoded Body : ${decodedBody}");

        LoginModel model =
            LoginModel.fromJson(decodedBody.cast<String, dynamic>());
        await AuthUtility.saveUserInfo(model);

        String token = decodedBody['token'];
        print("token is from login : ${decodedBody['token']}");
        loginToken = decodedBody['token'];
        authUserID = decodedBody['id'];
        await preferences.setString(
            'token',
            decodedBody['token'] ??
                token ??
                loginToken ??
                decodedBody['token']);
        print("Image name:       ${decodedBody['image']}");
        print("ID after image:  ${decodedBody['id']}");

        await preferences.setString('authUserID', authUserID ?? '');
        await preferences.setString('image', decodedBody['image']);

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
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
        child: Scaffold(
      body: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    "Registration",
                    style: TextStyle(fontSize: 36, color: Colors.black),
                  )),
                  height20,
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
                    validatorText: 'Enter Password',
                    textEditingController: passwordController,
                    hintText: 'Enter Password',
                    obscureText: !passwordVisible,
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
                  TextFieldUpperText(
                    text: 'Confirm Password',
                  ),
                  NewPasswordTextFormField(
                    validatorText: 'Enter Password',
                    textEditingController: confirmPasswordController,
                    obscureText: !confirmPasswordVisible,
                    hintText: 'Confirm Password',
                    icon: IconButton(
                        icon: Icon(
                          confirmPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey.shade800,
                        ),
                        onPressed: () {
                          setState(() {
                            confirmPasswordVisible = !confirmPasswordVisible;
                          });
                        }),
                  ),
                  height20,
                  isRegistrationInProgress
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
                  height30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      width5,
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewLoginScreen()),
                              (route) => false);
                        },
                        child: Text(
                          "Login",
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
