import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/new_single_screen/new_single_screen_vehicle.dart';
import 'package:pilot_bazar_admin/screens/single_vehicle_screen.dart';

class BottomNavBaseScreen extends StatefulWidget {
  @override
  _BottomNavBaseScreenState createState() => _BottomNavBaseScreenState();
}

class _BottomNavBaseScreenState extends State<BottomNavBaseScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const NewSingleScreenVehicle(),
    const NewSingleScreenVehicle()
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
            showUnselectedLabels: false, // Hide the labels for unselected items
            showSelectedLabels: false, // Hide the labels for selected items
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/shopping.png',
                  height: 20,
                ),
                label:
                    '', // Even though label is empty, it won't take extra space
              ),
              BottomNavigationBarItem(
                icon: Container(), // Or an invisible item if needed
                label: '', // This will also not take extra space
              ),
            ],
          ),
        ),
      ),
    );
  }
}
