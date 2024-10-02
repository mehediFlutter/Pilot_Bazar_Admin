import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/screens/single_vehicle_screen.dart';

class BottomNavBaseScreen extends StatefulWidget {
  @override
  _BottomNavBaseScreenState createState() => _BottomNavBaseScreenState();
}

class _BottomNavBaseScreenState extends State<BottomNavBaseScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const SingleVehicleScreen(),
    const SingleVehicleScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            border: Border.all(color: const Color(0xFFEEEEEE))),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.single_bed),
                label: 'Single Screen',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.single_bed),
                label: 'Single Screen',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
