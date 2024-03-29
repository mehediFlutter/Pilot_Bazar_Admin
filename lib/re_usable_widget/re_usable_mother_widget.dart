import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/package/drawer/drawer.dart';
import 'package:pilot_bazar_admin/practice/drawer_practice.dart';

class ReUsableMotherWidget extends StatelessWidget {
    final ValueNotifier<ThemeMode> notifier;

  final List<Widget> children;
 // final Drawer? drawer;
  final MainAxisAlignment? mainAxis;
  final CrossAxisAlignment? crossAxis;
  final bool isSingleChildScrollView;

  const ReUsableMotherWidget({
    Key? key,
    required this.children,
    this.isSingleChildScrollView = false,
    this.mainAxis,
    this.crossAxis, required this.notifier,
  //  this.drawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget column = Column(
      mainAxisAlignment: mainAxis ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxis ?? CrossAxisAlignment.start,
      children: children,
    );
  //  Widget drawer = Drawer();
    return SafeArea(
      
      child: Scaffold(
        drawer: MyDrawer(notifier: notifier,),
        body: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: isSingleChildScrollView
              ? SingleChildScrollView(child: column)
              : column,
        ),
      ),
    );
  }
}
