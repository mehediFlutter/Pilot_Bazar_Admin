import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/screens/auth/auth_utility.dart';
import 'package:pilot_bazar_admin/screens/auth/loain_model.dart';
import 'package:pilot_bazar_admin/screens/auth/login_and_registration.dart';
import 'package:pilot_bazar_admin/screens/auth/new_login_screen/new_login_screen.dart';
import 'package:pilot_bazar_admin/widget/alert_dialog.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';

class CustomerProfileBar extends StatefulWidget {
  final String profileImagePath;
  final String? notification_image_path;
  final String? drawer_icon_path;
  final String? merchantName;
  final String? phone;
  final String? chatAvater;
  final bool isChatAvater;
  final Function()? onTapFunction;
  final Function()? chatTap;
  final Function()? drawerTap;
  const CustomerProfileBar({
    super.key,
    required this.profileImagePath,
    this.onTapFunction,
    this.chatTap,
    this.notification_image_path,
    this.drawer_icon_path,
    this.drawerTap,
    this.merchantName,
    this.phone,
    this.chatAvater,
    this.isChatAvater = false,
  });

  @override
  State<CustomerProfileBar> createState() => _CustomerProfileBarState();
}

class _CustomerProfileBarState extends State<CustomerProfileBar> {
  @override
  var userInfo;
  loadUserInfo() async {
    LoginModel user = await AuthUtility.getUserInfo();
    userInfo = user.toJson();
    setState(() {});
    print(userInfo.toString());
    print(userInfo['name'].toString());
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column(

          //  onTap: widget.onTapFunction,
          children: [
            Row(
              children: [
                Container(
                  height: 32,
                  width: 32,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadious10,
                  ),
                  child: Image.network(
                    widget.isChatAvater
                        ? widget.chatAvater ?? ''
                        : (widget.profileImagePath.isNotEmpty)
                            ? widget.profileImagePath
                            : errorPerson,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.merchantName ?? 'None',
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        height: 0,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.phone ?? 'None',
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        height: 0,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                ElevatedButton(
                    onPressed: () {
                      CustomAlertDialog().logOutDialog(
                          context,
                          "Are you sure want to logOut ? ",
                          'Yes',
                          'No', () async {
                        await AuthUtility.clearUserInfo();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewLoginScreen()),
                            (route) => false);
                        await loadUserInfo();
                      });
                    },
                    child: Text("Logout")),
                SvgPicture.asset(
                  widget.notification_image_path ?? '',
                ),
              ],
            ),
          ]),
    );
  }
}
