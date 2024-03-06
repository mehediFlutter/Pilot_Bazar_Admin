import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';

class CustomerListTile extends StatefulWidget {
  const CustomerListTile({super.key});

  @override
  State<CustomerListTile> createState() => _CustomerListTileState();
}

class _CustomerListTileState extends State<CustomerListTile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          ListTile(
            leading: Container(
              height: 30,
              width: 35,
              child: Image.asset('assets/images/small_profile.png')),
          ),
        ],
      ),
    ));
  }
}
