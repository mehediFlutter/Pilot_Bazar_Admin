import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/provider/profile_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  getProfileDetailsMethod() async {
    final provider =
        Provider.of<ProfileProvider>(context, listen: false).getProfile();
  }

  @override
  void initState() {
    getProfileDetailsMethod();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Name"),
          Text("Company Name"),
          Text("Email "),
          Text("Phone Number "),
        ],
      ),
    ));
  }
}
