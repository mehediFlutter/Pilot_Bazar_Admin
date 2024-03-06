import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_listTile.dart';

class PilotBazarAdmin extends StatefulWidget {
  const PilotBazarAdmin({super.key});

  @override
  State<PilotBazarAdmin> createState() => _PilotBazarAdminState();
}

class _PilotBazarAdminState extends State<PilotBazarAdmin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: CustomerListTile(),
    );
  }
}
