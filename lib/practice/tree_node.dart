import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/drawer/drawer_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer(),
      body: Column(
        children: [
          ListTile(
            title: Text("Hello"),
            trailing: Builder( 
              builder: (BuildContext context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer(); // Use the context provided by Builder
                  },
                  icon: Icon(Icons.menu), // Change the icon to menu
                );
              },
            ),
          ),
          Center(
            child: Text('Home Page'),
          ),
        ],
      ),
    );
  }
}

// class myDrawer extends StatelessWidget {
//   const myDrawer({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: BoxDecoration(
//               color: Colors.blue,
//             ),
//             child: Text(
//               'Drawer Header',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//               ),
//             ),
//           ),
//           ListTile(
//             title: Text('Item 1'),
//             onTap: () {
//               // Add your action here
//               Navigator.pop(context); // Close the drawer
//             },
//           ),
//           ListTile(
//             title: Text('Item 2'),
//             onTap: () {
//               // Add your action here
//               Navigator.pop(context); // Close the drawer
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
