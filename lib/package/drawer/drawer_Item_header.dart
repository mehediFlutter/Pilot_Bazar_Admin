// import 'package:flutter/material.dart';

// class DrawerItemHeader extends StatelessWidget {

//   const DrawerItemHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//     onTap: onClick,
//     child: Container(
//       padding: EdgeInsets.only(left: 20),
//       width: double.infinity,
//       height: 59,
//       decoration: BoxDecoration(
//         borderRadius: borderRadious10,
//         border: isCustomerClick ? Border.all(color: Colors.blue) : null,
//       ),
//       child: Row(
//         children: [
//           Image.asset(
//             'assets/icons/drawer_customer.png',
//             color: isCustomerClick ? Colors.blue : Color(0xFF666666),
//           ),
//           SizedBox(width: 20),
//           Text(
//             'Customers',
//             style: small14StyleW500.copyWith(
//               color: isCustomerClick ? Colors.blue : Colors.black,
//             ),
//           ),
//           Spacer(),
//           Transform.rotate(
//             angle: isCustomerClick ? 1.5708 : 0, // 90 degrees in radians
//             child: Icon(
//               Icons.arrow_forward_ios_outlined,
//               size: 18,
//               color: isCustomerClick ? Colors.blue : null,
//             ),
//           ),
//           SizedBox(width: 20),
//         ],
//       ),
//     ),
//   );;
//   }
// }