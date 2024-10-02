import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/package/drawer/drawer.dart';

class ReUsableMotherWidget extends StatelessWidget {
  final List<Widget> children;
  // final Drawer? drawer;
  final MainAxisAlignment? mainAxis;
  final CrossAxisAlignment? crossAxis;
  final bool isSingleChildScrollView;
  final bool isFloatingActionButton;
  const ReUsableMotherWidget({
    Key? key,
    required this.children,
    this.isSingleChildScrollView = false,
    this.mainAxis,
    this.crossAxis,
    this.isFloatingActionButton = false,
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
        drawer: MyDrawer(),
        floatingActionButton: isFloatingActionButton
            ? Row(
                children: children,
              )
            : const SizedBox(),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: isSingleChildScrollView
              ? SingleChildScrollView(child: column)
              : column,
        ),
      ),
    );
  }
}
