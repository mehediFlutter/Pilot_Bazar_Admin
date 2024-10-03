// import 'package:flutter/material.dart';
// import 'package:pilot_bazar_admin/const/const_radious.dart';
// import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';
// import 'package:pilot_bazar_admin/package/drawer/drawer.dart';
// import 'package:pilot_bazar_admin/screens/auth/auth_utility.dart';
// import 'package:pilot_bazar_admin/screens/auth/loain_model.dart';
// import 'package:pilot_bazar_admin/widget/item.dart';
// import 'package:pilot_bazar_admin/widget/search_text_fild.dart';

// class DoubleVehicleScreen extends StatefulWidget {
//   const DoubleVehicleScreen({super.key});

//   @override
//   State<DoubleVehicleScreen> createState() => _DoubleVehicleScreenState();
// }

// class _DoubleVehicleScreenState extends State<DoubleVehicleScreen> {
//   @override
//   Map<String, dynamic>? userInfo;
//   TextEditingController searchController = TextEditingController();

//   loadUserInfo() async {
//     LoginModel user = await AuthUtility.getUserInfo();
//     userInfo = user.toJson();
//     setState(() {});
//   }

//   void initState() {
//     loadUserInfo();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         drawer: MyDrawer(),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30),
//           child: Column(
//             children: [
//               Builder(builder: (context) {
//                 return CustomerProfileBar(
//                   profileImagePath: userInfo?['payload']?['merchant']
//                           ?['merchant_info']?['image']?['name'] ??
//                       '',
//                   message_icon_path: 'assets/icons/message_notification.png',
//                   drawer_icon_path: 'assets/icons/beside_message.png',
//                   merchantName:
//                       userInfo?['payload']?['merchant']?['name'] ?? 'None',
//                   companyName: userInfo?['payload']?['merchant']
//                           ?['merchant_info']['company_name'] ??
//                       "None",

//                   // onTapFunction: () {
//                   //   Navigator.push(
//                   //       context,
//                   //       MaterialPageRoute(
//                   //           builder: (context) => CustomerPersonalInfo()));
//                   // },
//                   // chatTap: () {
//                   //   print("notificaiton tap");
//                   //   Navigator.push(
//                   //       context,
//                   //       MaterialPageRoute(
//                   //           builder: (context) => ChatFontScreen()));
//                   // },
//                   // drawerTap: () {
//                   //   Scaffold.of(context).openDrawer();

//                   // },
//                 );
//               }),
//               SearchTextFild(
//                 searchController: searchController,
//               ),
//               height20,
//               Expanded(
//                 child: GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 2.0,
//                     crossAxisSpacing: 0.0,
//                   ),
//                   itemCount: 20,
//                   itemBuilder: (BuildContext context, index) {
//                     return Padding(
//                         padding: const EdgeInsets.only(bottom: 20),
//                         child: Item(indexItem: productws,));
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
