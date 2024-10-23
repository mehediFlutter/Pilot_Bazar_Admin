import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pilot_bazar_admin/DTO/profile_informationDTO.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/const/path.dart';
import 'package:pilot_bazar_admin/provider/profile_provider.dart';
import 'package:pilot_bazar_admin/screens/auth/loain_model.dart';
import 'package:pilot_bazar_admin/screens/auth/new_registration_screen/text_fild_upper_text.dart';
import 'package:pilot_bazar_admin/screens/auth/new_text_fildes/new_name_text_fild.dart';
import 'package:pilot_bazar_admin/screens/auth/new_text_fildes/new_phone_number_text_fild.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  Map? profileDetails;
  SharedPreferences? preferences;

  update() async {
    preferences = await SharedPreferences.getInstance();
    Response response = await http.put(
        Uri.parse('$APP_APISERVER_URL/api/v1/vendor-management/profile'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Accept-Encoding': 'application/gzip',
          'Authorization': 'Bearer ${preferences?.getString('token')}'
        },
        body: jsonEncode(
          {
            'name': nameController.text,
            'phone': phoneNumberController.text,
            'email': emailController.text
          },
        )

        // body: {
        //   'name': nameController.text,
        //   'phone': phoneNumberController.text,
        // },

        );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200){
   
    }
  }

  getProfileDetailsMethod() async {
    profileDetails =
        await Provider.of<ProfileProvider>(context, listen: false).getProfile();
    setState(() {});
    print("Profile details is");
    print(profileDetails);
    nameController.text = profileDetails?['name'];
    emailController.text = (profileDetails?['email'] ?? 'None');
    phoneNumberController.text = (profileDetails?['phone'] ?? 'None');
  }

  @override
  void initState() {
    getProfileDetailsMethod();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              height25,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back)),
                  Text(
                    "Profile",
                    style: TextStyle(fontSize: 16),
                  ),
                  SvgPicture.asset('$iconPath/edit.svg')
                ],
              ),
              height15,
              TextFieldUpperText(
                text: 'Name',
              ),
              height10,
              NewNameTextFormField(
                hintText: nameController.text.isEmpty ? 'Enter Name' : '',
                textEditingController: nameController,
                validatorText: 'Enter Name',
                keyboardType: TextInputType.text,
              ),
              height16,
              TextFieldUpperText(
                text: 'Email',
              ),
              NewNameTextFormField(
                hintText: emailController.text.isEmpty ? 'Enter Email' : '',
                textEditingController: emailController,
                validatorText: 'Enter Name',
                keyboardType: TextInputType.emailAddress,
              ),
              height16,
              TextFieldUpperText(
                text: 'Phone Number',
              ),
              NewPhoneNumberTextFormField(
                  textEditingController: phoneNumberController,
                  hintText: phoneNumberController.text.isEmpty
                      ? 'Enter Phone Number'
                      : '',
                  validatorText: "Enter Phone Number"),
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
                      await update();
                    },
                    child: Text(
                      "Update",
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
