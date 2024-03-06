import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';

class AdminCustomerNotification extends StatefulWidget {
  const AdminCustomerNotification({super.key});

  @override
  State<AdminCustomerNotification> createState() => _AdminCustomerNotificationState();
}

class _AdminCustomerNotificationState extends State<AdminCustomerNotification> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: whiteColor,
    ));
  }
}