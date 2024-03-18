import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/drawer/my_drawer.dart';

class ReUsableMotherWidget extends StatelessWidget {
  final List<Widget> childred;
  final MainAxisAlignment? mainAxis;
  final CrossAxisAlignment? crossAxis;
  final bool isSingleChildScrollView;
  const ReUsableMotherWidget(
      {super.key,
      required this.childred,
      this.isSingleChildScrollView = false,
      this.mainAxis,
      this.crossAxis});

  @override
  Widget build(BuildContext context) {
    Widget column = Column(
      mainAxisAlignment: mainAxis ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxis ?? CrossAxisAlignment.start,
      children: childred,
    );
    return SafeArea(
        child: Scaffold(
          drawer: MyDrawer(),
            body: Padding(
              padding:  EdgeInsets.only(left: 20,right: 20),
              child: isSingleChildScrollView
                  ? SingleChildScrollView(child: column)
                  : column,
            )
                
                ));
  }
}
