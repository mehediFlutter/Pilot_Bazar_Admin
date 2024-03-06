import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/admin_customer_notification.dart';
import 'package:pilot_bazar_admin/re_usable_widget/re_usable_mother_widget.dart';

class PilotBazarAdmin extends StatefulWidget {
  const PilotBazarAdmin({super.key});

  @override
  State<PilotBazarAdmin> createState() => _PilotBazarAdminState();
}

class _PilotBazarAdminState extends State<PilotBazarAdmin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: AdminCustomerNotification(),
    );
  }
}
