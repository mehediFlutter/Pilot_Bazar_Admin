import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    super.key,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Your drawer content
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Draer header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            //  contentPadding: EdgeInsets.zero,
            leading: Image.asset('assets/icons/drawer_home.png'),
            title: Text('Home', style: small14StyleW500),
            onTap: () {
              // Do something
              Navigator.pop(context); // Close the drawer
            },
          ),
          Container(
            height: 59,
            width: 254,
            decoration: BoxDecoration(
              borderRadius: borderRadious10,
              border: Border.all(color: searchBarBorderColor)
              
            ),
            child: ListTile(
              leading: Icon(Icons.person_2_rounded),
              title: Text("Customers"),
              trailing: Icon(Icons.arrow_forward),
            ),
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Do something
              Navigator.pop(context); // Close the drawer
            },
          ),
        ],
      ),
    );
  }
}
