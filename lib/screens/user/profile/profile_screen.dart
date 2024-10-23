import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/provider/profile_provider.dart';
import 'package:pilot_bazar_admin/screens/auth/new_text_fildes/new_name_text_fild.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  Map? userInformation;
  getProfileDetailsMethod() async {
    userInformation =
        await Provider.of<ProfileProvider>(context, listen: false).getProfile();
    setState(() {});
  }

  @override
  void initState() {
    getProfileDetailsMethod();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NewNameTextFormField(
            hintText: '',
            textEditingController: nameController,
            validatorText: '',
            keyboardType: TextInputType.text,
          ),
          Text(userInformation?['name'] ?? ''),
          Text(userInformation?['email'] ?? ''),
          Text(userInformation?['phone'] ?? ''),
        ],
      ),
    ));
  }
}
