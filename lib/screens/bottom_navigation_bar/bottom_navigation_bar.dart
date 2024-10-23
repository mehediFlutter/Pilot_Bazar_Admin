import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pilot_bazar_admin/const/path.dart';
import 'package:pilot_bazar_admin/screens/new_single_screen/new_single_screen_vehicle.dart';
import 'package:pilot_bazar_admin/screens/user/user_screen.dart';

class BottomNavBaseScreen extends StatefulWidget {
  @override
  _BottomNavBaseScreenState createState() => _BottomNavBaseScreenState();
}

class _BottomNavBaseScreenState extends State<BottomNavBaseScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const NewSingleScreenVehicle(),
    const NewSingleScreenVehicle(),
    const NewSingleScreenVehicle(),
    const UserScreen(),
  ];
  final List<Map<String, String>> navBarItems = [
    {
      'filled': '$newIconPath/home_filled.svg',
      'outline': '$newIconPath/home_outline.svg',
    },
    {
      'filled': '$newIconPath/player--filled.svg',
      'outline': '$newIconPath/player-outline.svg',
    },
    {
      'filled': '$newIconPath/message-filled.svg',
      'outline': '$newIconPath/message-outline.svg',
    },
    {
      'filled': '$newIconPath/user-filled.svg',
      'outline': '$newIconPath/user-outline.svg',
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print("current index $_selectedIndex");
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
            selectedItemColor:
                Colors.black, // Color for selected item (label and icon)
            unselectedItemColor:
                Colors.grey, // Color for unselected item (label and icon)
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  _selectedIndex == 0
                      ? '$iconPath/new_home_filled.svg'
                      : '$iconPath/new_home_outline.svg',
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  _selectedIndex == 1
                      ? '$iconPath/new_reels_filled.svg'
                      : '$iconPath/new_reels_outline.svg',
                ),
                label: 'Reel',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  _selectedIndex == 2 //new_chat_filled.svg
                      ? '$iconPath/new_chat_filled.svg'
                      : '$iconPath/new_chat_outline.svg',
                ),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  _selectedIndex == 3
                      ? '$iconPath/new_person_filled.svg'
                      : '$iconPath/new_person_outline.svg',
                ),
                label: 'User',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
