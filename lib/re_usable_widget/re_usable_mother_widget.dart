import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';

class ReUsableMotherWidget extends StatelessWidget {
  final List<Widget> childred; 
  final bool? isScrollable;
  const ReUsableMotherWidget({super.key, required this.childred, this.isScrollable=false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appColor,
      body: Column(
        children: childred,
      )
    ));
  }
}