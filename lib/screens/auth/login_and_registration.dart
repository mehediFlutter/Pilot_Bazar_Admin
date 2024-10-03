import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/screens/auth/login_screen.dart';
import 'package:pilot_bazar_admin/screens/auth/registration_screen.dart';

class TabBarViewLoginAndRegistration extends StatefulWidget {
  @override
  _TabBarViewLoginAndRegistrationState createState() =>
      _TabBarViewLoginAndRegistrationState();
}

class _TabBarViewLoginAndRegistrationState
    extends State<TabBarViewLoginAndRegistration>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        // Forces the widget to rebuild when the tab changes
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          height10,
          _tabController.index == 0
              ? const Text(
                  "Login",
                  style: TextStyle(fontSize: 24),
                )
              : const Text(
                  "Register",
                  style: TextStyle(fontSize: 24),
                ),
          height10,
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.transparent,
            dividerColor: Colors.transparent,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black,
            tabs: const [
              Tab(
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Tab(
                child: Text(
                  "Registration",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [LoginScreen(), const RegistrationScreen()],
            ),
          ),
        ],
      ),
    );
  }
}
