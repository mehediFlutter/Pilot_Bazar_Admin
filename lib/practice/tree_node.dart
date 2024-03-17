import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/practice/shor_info_practice.dart';

void main() {
  runApp(MaterialApp(home: MainClass()));
}

class MainClass extends StatefulWidget {
  @override
  State<MainClass> createState() => _MainClassState();
}

class _MainClassState extends State<MainClass> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  String customText='Car model 1012';

  @override
  Widget build(BuildContext context) {
    return ReUsableMotherWidgetForPractce(
    //  scaffoldKey: _scaffoldKey,
      childred: [
        GestureDetector(
          onTap: () {
           
            _scaffoldKey.currentState!.openDrawer();
          },
          child: ProfileBanner(
            iconPath: 'assets/icons/beside_message.png',
          
          ),
        ),
      ],
    );
  }
}

class ProfileBanner extends StatelessWidget {
  final String iconPath;

  ProfileBanner({
    Key? key,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: GestureDetector(
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
        child: Container(
          height: 30,
          width: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
          child: Image.asset(iconPath),
        ),
      ),
    );
  }
}

class ReUsableMotherWidgetForPractce extends StatelessWidget {
  final List<Widget> childred;
  final MainAxisAlignment? mainAxis;
  final CrossAxisAlignment? crossAxis;
  final bool isSingleChildScrollView;
 // final GlobalKey<ScaffoldState> scaffoldKey;

  ReUsableMotherWidgetForPractce({
    Key? key,
   // required this.scaffoldKey,
    required this.childred,
    this.isSingleChildScrollView = false,
    this.mainAxis,
    this.crossAxis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget column = Column(
      mainAxisAlignment: mainAxis ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxis ?? CrossAxisAlignment.start,
      children: childred,
    );
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(headerText: 'hello',),
      //  key: scaffoldKey,
        body: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: isSingleChildScrollView ? SingleChildScrollView(child: column) : column,
        ),
      ),
    );
  }
}