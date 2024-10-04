import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_font_screen.dart';
import 'package:pilot_bazar_admin/package/customer_requirement_store/customer_personal_info.dart';
import 'package:pilot_bazar_admin/package/drawer/drawer_bool.dart';
import 'package:pilot_bazar_admin/screens/auth/auth_utility.dart';
import 'package:pilot_bazar_admin/screens/auth/loain_model.dart';
import 'package:pilot_bazar_admin/screens/auth/login_and_registration.dart';
import 'package:pilot_bazar_admin/screens/auth/login_screen.dart';
import 'package:pilot_bazar_admin/screens/auth/registration_screen.dart';
import 'package:pilot_bazar_admin/mode_provider.dart';
import 'package:pilot_bazar_admin/widget/alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    super.key,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override

  // Home Bool
  bool isHomeClick = false;

// Customer Bool
  bool isCustomerClick = false;
  bool isCreateBool = false;
  bool isViewClick = false;

// Message Bool
  bool isMessageBool = false;
  bool isFollowUpBool = false;
  bool isFeedbackBool = false;
  bool isPackageBool = false;

// Settings Bool
  bool isSettingsBool = false;
  bool isLogOutBool = false;
  int? emniNumber;

  bool? isShowAnimationContainer;
  late SharedPreferences preffs;

  double calculateHeight() {
    return isCustomerClick ? 90.0 : 0.0;
  }

  universalFinalClick() {
    universalCustumerClick();
  }

  universalCustumerClick() {
    if (universalCustomBool == true) {
      isCustomerClick = true;

      setState(() {});
    } else if (universalCustomBool == true && universalViewBool == true) {
      isViewClick = true;
      setState(() {});
    }
  }

  universalMessageClick() {
    if (universalMessageBool == true) {
      isMessageBool = true;
      setState(() {});
    }
  }

  universalCreate() {
    if (universalCreateBool == true) {
      isCreateBool = true;
      universalViewBool = false;
      setState(() {});
    }
  }

  universalFollowUp() {
    if (universalFollowUpBool == true) {
      isFollowUpBool = true;
      universalFeedBool = false;
      universalPackageBool = false;
    }
  }

  universalView() {
    if (universalViewBool == true) {
      isViewClick = true;
      universalCreateBool = false;
      setState(() {});
    }
  }

  var userInfo;

  loadUserInfo() async {
    LoginModel user = await AuthUtility.getUserInfo();
    userInfo = user.toJson();
    setState(() {});
    print(userInfo.toString());
    print(userInfo['payload']['merchant']['name'].toString());
  }

  @override
  void initState() {
    universalCustumerClick();
    universalCreate();
    universalView();
    universalMessageClick();
    // message
    universalFollowUp();
  }

  @override
  Widget build(BuildContext context) {
    Color changableIconColor;
    Color colorMethode(bool isBool) {
      return changableIconColor =
          isBool ? activeDrawerItemIconColor : inActiveDrawerItemIconColor;
    }

    return Drawer(
      // Your drawer content
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // drawerItemHeader(
                //     isArrow: false,
                //     isBool: isHomeClick,
                //     iconPath: 'assets/icons/drawer_home.png',
                //     text: 'Home',
                //     onClick: () {
                //       isHomeClick = !isHomeClick;
                //       isCustomerClick = false;
                //       isMessageBool = false;

                //       setState(() {});
                //     }),

                // drawerItemHeader(
                //   isBool: isCustomerClick,
                //   iconPath: 'assets/icons/drawer_customer.png',
                //   text: 'Customer',
                //   onClick: () async {
                //     isCustomerClick = !isCustomerClick;
                //     universalCustomBool = isCustomerClick;

                //     // if (isCustomerClick == false) {
                //     //   isCreateBool = false;
                //     //   universalCreateBool = false;
                //     //   isViewClick = false;
                //     //   universalViewBool = false;
                //     //   setState(() {});
                //     // }

                //     isMessageBool = false;
                //     universalMessageBool = false;

                //     setState(() {});
                //   },
                // ),

                // AnimatedContainer(
                //   duration: const Duration(milliseconds: 300),
                //   curve: Curves.easeInOut,
                //   height: isCustomerClick ? 90 : 0,
                //   child: Visibility(
                //     visible: isCustomerClick,
                //     child: Column(
                //       children: [
                //         itemOfHeader(
                //           clickBoolName: isCreateBool,
                //           customIcon: Icon(
                //             Icons.add,
                //             color: colorMethode(isCreateBool),
                //           ),
                //           text: 'Personal/Create',
                //           onClick: () async {
                //             isCreateBool = true;
                //             universalCreateBool = true;
                //             universalViewBool = false;
                //             isViewClick = false;

                //             setState(() {});
                //             Navigator.pop(context);
                //             await Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) =>
                //                         CustomerPersonalInfo()));
                //           },
                //         ),
                //         itemOfHeader(
                //           clickBoolName: isViewClick,
                //           isTrailling: true,
                //           customIcon: Icon(
                //             Icons.person,
                //             color: colorMethode(isViewClick),
                //           ),
                //           text: 'Budget/View',
                //           onClick: () async {
                //             isViewClick = true;

                //             isCreateBool = false;
                //             universalViewBool = true;
                //             universalCreateBool = false;
                //             setState(() {});

                //             Navigator.pop(context);
                //             await Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) => ChatFontScreen()));

                //             setState(() {});
                //           },
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                //    Message

                //  Message Icon Drawer
                // drawerItemHeader(
                //     isBool: isMessageBool,
                //     iconPath: 'assets/icons/drawer_message.png',
                //     text: 'Message',
                //     onClick: () {
                //       // offline customer child

                //       // End of Off customer child

                //       isMessageBool = !isMessageBool;
                //       universalMessageBool = isMessageBool;

                //       // if message if false then all child of message is offline

                //       isFollowUpBool = false;
                //       universalFollowUpBool = false;
                //       isFeedbackBool = false;
                //       universalFeedBool = false;
                //       isPackageBool = false;
                //       universalPackageBool = false;
                //       setState(() {});

                //       isFeedbackBool = false;

                //       // Hide Customer Parent
                //       universalCustomBool = false;
                //       isCustomerClick = false;
                //       // Success Hide Custom Parent

                //       setState(() {});
                //     }),
                // AnimatedContainer(
                //   duration: const Duration(milliseconds: 300),
                //   curve: Curves.easeInOut,
                //   height: isMessageBool ? 140 : 0,
                //   child: Visibility(
                //     visible: isMessageBool,
                //     child: Column(
                //       children: [
                //         itemOfHeader(
                //           iconPath: 'assets/icons/drawer_followUp.png',
                //           isIconPath: true,
                //           clickBoolName: isFollowUpBool,
                //           text: 'Follow Up',
                //           onClick: () {
                //             isFollowUpBool = !isFollowUpBool;
                //             universalFollowUpBool = isFollowUpBool;

                //             isFeedbackBool = false;
                //             isPackageBool = false;

                //             setState(() {});
                //             Navigator.pushAndRemoveUntil(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) =>
                //                         CustomerPersonalInfo()),
                //                 (route) => false);
                //           },
                //         ),
                //         itemOfHeader(
                //           iconPath: 'assets/icons/drawer_feedBack.png',
                //           isIconPath: true,
                //           clickBoolName: isFeedbackBool,
                //           text: 'Feed ',
                //           onClick: () {
                //             isFeedbackBool = !isFeedbackBool;
                //             isFollowUpBool = false;
                //             isPackageBool = false;
                //             setState(() {});
                //           },
                //         ),
                //         itemOfHeader(
                //           iconPath: 'assets/icons/drawer_package.png',
                //           isIconPath: true,
                //           clickBoolName: isPackageBool,
                //           text: 'Package',
                //           onClick: () {
                //             isPackageBool = !isPackageBool;
                //             isFollowUpBool = false;
                //             isFeedbackBool = false;
                //             setState(() {});
                //           },
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                // drawerItemHeader(
                //     isBool: isSettingsBool,
                //     iconPath: 'assets/icons/drawer_settings.png',
                //     text: 'Settings',
                //     onClick: () {
                //       isSettingsBool = !isSettingsBool;
                //       setState(() {
                //         print(isLogOutBool);
                //       });
                //     }),
                drawerItemHeader(
                    isBool: isSettingsBool,
                    iconPath: 'assets/icons/shopping.png', //drawer_settings.png
                    text: 'My Shop',
                    onClick: () {
                      isSettingsBool = !isSettingsBool;
                      setState(() {
                        Navigator.pop(context);
                      });
                    }),
                drawerItemHeader(
                    isBool: isLogOutBool,
                    iconPath: 'assets/icons/drawer_logOut.png',
                    text: 'Log Out',
                    onClick: () async {
                      CustomAlertDialog().logOutDialog(
                          context,
                          "Are you sure want to logOut ? ",
                          'Yes',
                          'No', () async {
                        await AuthUtility.clearUserInfo();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TabBarViewLoginAndRegistration()));
                        await loadUserInfo();
                      });
                      isLogOutBool = !isLogOutBool;
                      setState(() {});
                    }),

                // change theme

                // ElevatedButton(
                //     onPressed: () async {
                //       Provider.of<ModeProvider>(context, listen: false)
                //           .changeMode();

                //       preffs = await SharedPreferences.getInstance();

                //       setState(() {});
                //     },
                //     child: const Text("Moode")),

                // ElevatedButton(
                //     onPressed: () {

                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => LoginScreen()));
                //     },
                //     child: Text(
                //       "Login",
                //       style: TextStyle(color: Colors.black),
                //     )),
                // ElevatedButton(
                //     onPressed: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => RegistrationScreen()));
                //     },
                //     child: Text(
                //       "Registration",
                //       style: TextStyle(color: Colors.black),
                //     )),
                // ElevatedButton(
                //     onPressed: () async {
                //       await AuthUtility.clearUserInfo();
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => LoginScreen()));
                //       await loadUserInfo();
                //     },
                //     child: Text(
                //       "Log Out",
                //       style: TextStyle(color: Colors.black),
                //     )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  drawerItemHeader(
      {required Function() onClick,
      String? iconPath,
      text,
      Widget? customIcon,
      bool isArrow = true,
      bool isImage = false,
      isBool}) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        width: double.infinity,
        height: 59,
        decoration: BoxDecoration(
          borderRadius: borderRadious10,
          border: isBool ? Border.all(color: Colors.blue) : null,
        ),
        child: Row(
          children: [
            Image.asset(
              iconPath ?? '',
              color: isBool ? Colors.blue : const Color(0xFF666666),
            ),
            const SizedBox(width: 20),
            Text(
              text,
              style: small14StyleW500.copyWith(
                color: isBool ? Colors.blue : Colors.black,
              ),
            ),
            const Spacer(),
            // isArrow
            //     ? Transform.rotate(
            //         angle: isBool ? 1.5708 : 0, // 90 degrees in radians
            //         child: Icon(
            //           Icons.arrow_forward_ios_outlined,
            //           size: 18,
            //           color: isBool ? Colors.blue : null,
            //         ),
            //       )
            //     : const SizedBox(),
            // const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }

  Widget itemOfHeader(
      {required Function() onClick,
      required String text,
      iconPath,
      Widget? customIcon,
      image,
      required bool clickBoolName,
      isTrailling = false,
      isIconPath = false}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            onClick(); // Call the provided onClick callback
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            children: [
              isIconPath
                  ? Image.asset(
                      iconPath,
                      fit: BoxFit.cover,
                    )
                  : customIcon ?? const SizedBox(),
              const SizedBox(width: 20),
              Text(
                text,
                style: clickBoolName ? activedDrawerItem : inActivedDrawerItem,
              ),
              const Spacer(),
              isTrailling
                  ? Text(
                      '20',
                      style: clickBoolName
                          ? activedDrawerItem
                          : inActivedDrawerItem,
                    )
                  : const SizedBox(),
              width20
            ],
          ),
        ),
      ),
    );
  }
}
