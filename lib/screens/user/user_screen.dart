import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/const/path.dart';
import 'package:pilot_bazar_admin/screens/auth/auth_utility.dart';
import 'package:pilot_bazar_admin/screens/auth/loain_model.dart';
import 'package:pilot_bazar_admin/screens/user/profile/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    printUserInfo();
    _startAnimation();
  }

  double _gradientPosition = 0.0;
  void _startAnimation() {
    // Continuously animate the gradient position
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _gradientPosition += 1.0; // Increment the position
      });
      if (_gradientPosition >= 1.0) {
        _gradientPosition = 0.0; // Reset after completing one cycle
      }
      _startAnimation(); // Repeat the animation
    });
  }

  SharedPreferences? preferences;
  LoginModel? userInfoFromPreference;
  void printUserInfo() async {
    userInfoFromPreference = await AuthUtility.getUserInfo();
    preferences = await SharedPreferences.getInstance();
    setState(() {});
    print("user name is  : ${userInfoFromPreference?.name}");
    print("Image is  : ${preferences?.getString('image')}");
    print(userInfoFromPreference?.image);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Profile",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            height20,
            Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF0093E9), Color(0xFF80D0C7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.network(
                    '${preferences?.getString('image') ?? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSk8RLjeIEybu1xwZigumVersvGJXzhmG8-0Q&s'}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            height16,
            Text(
              "Kabir Khan",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            height16,
            userMethode(
              'Profile',
              'new_person_outline.svg',
              () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            ),
            height12,
            userMethode(
              'Company',
              'company_icon.svg',
              () {},
            ),
            height12,
            userMethode(
              'Setting',
              'setting_icon.svg',
              () {},
            ),
            height12,
            userMethode(
              'Logout',
              'logout_icon.svg',
              () {},
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('$iconPath/app_version_icon.svg'),
                Text(
                  "App Version: 1.0.0",
                  style: TextStyle(color: Color(0xFF79747E)),
                )
              ],
            ),
            Text(
              "All Rights Reserve @PilotBazar",
              style: TextStyle(color: Color(0xFF79747E)),
            ),
            Text(
              "Powered By QubeNext",
              style: TextStyle(color: Color(0xFF79747E), fontSize: 12),
            ),
            height10,
          ],
        ),
      ),
    ));
  }

  userMethode(String title, icon, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Material(
        borderRadius: BorderRadius.circular(8),
        elevation: 1,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFFE7E7E7))),
              child: Row(
                children: [
                  SvgPicture.asset(
                    '$iconPath/$icon',
                  ),
                  width15,
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ],
              ),
            ),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}
