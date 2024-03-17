import 'package:flutter/material.dart';

class ProfileBanner extends StatelessWidget {
  final Function()? drawerTap;
  final String iconPath;

  const ProfileBanner({
    Key? key,
    this.drawerTap,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: GestureDetector(
        onTap: drawerTap,
        child: Container(
          height: 30,
          width: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), // Use BorderRadius.circular for border radius
            border: Border.all(color: Colors.black), // Example border color
          ),
          child: Image.asset(iconPath),
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(home: MainClass()));
// }

class MainClass extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: MyDrawer(headerText: 'hello',),
        body: Builder(
          builder: (BuildContext context) {
            return Column(
              children: [
                ProfileBanner(
                  iconPath: 'assets/icons/beside_message.png',
                  drawerTap: () {
                    print("pressed");
                    _scaffoldKey.currentState!.openDrawer();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class MyDrawer extends StatefulWidget {
  final String headerText;
  const MyDrawer({
    super.key, required this.headerText,
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
            child: Text(widget.headerText),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Do something
              Navigator.pop(context); // Close the drawer
            },
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
