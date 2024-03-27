// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         key: scaffoldKey, // Define scaffoldKey here
//         appBar: AppBar(title: Text('Demo')),
//         body: ReUsableMotherWidget(
//           drawer: Drawer(
//             child: Text("I am a drawer"),
//           ),
//           children: [
//             CustomerProfileBar(
//               profileImagePath: 'assets/images/small_profile.png',
//               message_icon_path: 'assets/icons/message_notification.png',
//               beside_message_icon_path: 'assets/icons/beside_message.png',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ReUsableMotherWidget extends StatelessWidget {
//   final List<Widget> children;
//   final Drawer? drawer;
//   final MainAxisAlignment? mainAxis;
//   final CrossAxisAlignment? crossAxis;
//   final bool isSingleChildScrollView;

//   const ReUsableMotherWidget({
//     Key? key,
//     required this.children,
//     this.isSingleChildScrollView = false,
//     this.mainAxis,
//     this.crossAxis,
//     this.drawer,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Widget column = Column(
//       mainAxisAlignment: mainAxis ?? MainAxisAlignment.start,
//       crossAxisAlignment: crossAxis ?? CrossAxisAlignment.start,
//       children: children,
//     );
//     return SafeArea(
//       child: Scaffold(
//         drawer: drawer,
//         body: Padding(
//           padding: EdgeInsets.only(left: 20, right: 20),
//           child: isSingleChildScrollView
//               ? SingleChildScrollView(child: column)
//               : column,
//         ),
//       ),
//     );
//   }
// }

// class CustomerProfileBar extends StatelessWidget {
//   final String? profileImagePath;
//   final String? message_icon_path;
//   final String? beside_message_icon_path;
//   final Function()? drawerTap;

//   const CustomerProfileBar({
//     Key? key,
//     this.profileImagePath,
//     this.message_icon_path,
//     this.beside_message_icon_path,
//     this.drawerTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       contentPadding: EdgeInsets.zero,
//       trailing: GestureDetector(
//         onTap: drawerTap,
//         child: Container(
//           height: 30,
//           width: 35,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8), // Use BorderRadius.circular instead of BorderRadious8
//             border: Border.all(color: Colors.black), // Use Colors.black instead of BorderRadious8Color
//           ),
//           child: Image.asset(
//             beside_message_icon_path ?? 'assets/icons/notification.png',
//           ),
//         ),
//       ),
//     );
//   }
// }
