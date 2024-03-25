import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/customer_requirement_store/customer_personal_info.dart';
import 'package:pilot_bazar_admin/package/drawer/drawer_bool.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    super.key,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  bool isHomeClick = false;
  bool isCustomerClick = false;
  bool? customerUniversalClick;
  bool isCreateBool = false;
  bool? createUniversalClick = false;
  bool isViewClick = false;

  bool isMessageClick = false;
  bool isFollowUpClick = false;
  bool isFeedbackClick = false;
  bool isPackageClick = false;

  bool isSettingsClick = false;
  bool isLogOutClick = false;
  int? emniNumber;

  bool? isShowAnimationContainer;

  double calculateHeight() {
    return isCustomerClick ? 90.0 : 0.0;
  }

  universalFinalClick() {
    universalCustumerClick();
  }

  universalCustumerClick() {
    if (customerUniversalBaseBool == true) {
      isCustomerClick = true;
      setState(() {});
    }
  }

  universalCreate() {
  //  print("universal Create bool ${universalCreateBool}");
    if (universalCreateBool == true) {
      isCreateBool = true;
      setState(() {});
      print("Now is create bool");
      print(isCreateBool);
    }
    else{
      print("Nothing found");
    }
  }

  @override
  void initState() {
    print("Customer Bool is here");
    print(customerUniversalBaseBool);
    universalCustumerClick();
    print("create bool  is here");
    print(isCreateBool);

   universalCreate();
       print(isCreateBool);
  }

  Widget build(BuildContext context) {
    Color changableIconColor;
    Color colorMethode(bool isBool) {
      return changableIconColor =
          isBool ? activeDrawerItemIconColor : inActiveDrawerItemIconColor;
    }

    return Drawer(
      // Your drawer content
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                drawerItemHeader(
                    isArrow: false,
                    isBool: isHomeClick,
                    iconPath: 'assets/icons/drawer_home.png',
                    text: 'Home',
                    onClick: () {
                      isHomeClick = !isHomeClick;
                      isCustomerClick = false;

                      setState(() {});
                    }),

                drawerItemHeader(
                  isBool: isCustomerClick,
                  iconPath: 'assets/icons/drawer_customer.png',
                  text: 'Customer',
                  onClick: () async {
                    isCustomerClick = !isCustomerClick;
                    customerUniversalBaseBool = isCustomerClick;

                    setState(() {});
                  },
                ),

                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: isCustomerClick ? 90 : 0,
                  child: Visibility(
                    visible: isCustomerClick,
                    child: Column(
                      children: [
                        itemOfHeader(
                          clickBoolName: isCreateBool,
                          customIcon: Icon(
                            Icons.add,
                            color: colorMethode(isCreateBool),
                          ),
                          text: 'Create',
                          onClick: () async {
                            print("Create is pressed");
                            isCreateBool = true;
                            universalCreateBool = true;
                            isViewClick = false;
                            setState(() {});
                            Navigator.pop(context);
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomerRequirementInputFilds()));
                          },
                        ),
                        itemOfHeader(
                          clickBoolName: isViewClick,
                          isTrailling: true,
                          customIcon: Icon(
                            Icons.person,
                            color: colorMethode(isViewClick),
                          ),
                          text: 'View',
                          onClick: () async {
                            isViewClick = true;
                            isCreateBool = false;
                            universalViewBool = true;
                            setState(() {});

                            Navigator.pop(context);
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomerRequirementInputFilds()));

                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                //    Message

                //  Message Icon Drawer
                drawerItemHeader(
                    isBool: isMessageClick,
                    iconPath: 'assets/icons/drawer_message.png',
                    text: 'Message',
                    onClick: () {
                      isMessageClick = !isMessageClick;
                      setState(() {});
                    }),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: isMessageClick ? 140 : 0,
                  child: Visibility(
                    visible: isMessageClick,
                    child: Column(
                      children: [
                        itemOfHeader(
                          iconPath: 'assets/icons/drawer_followUp.png',
                          isIconPath: true,
                          clickBoolName: isFollowUpClick,
                          text: 'Follow Up',
                          onClick: () {
                            isFollowUpClick = !isFollowUpClick;

                            isFeedbackClick = false;
                            isPackageClick = false;

                            setState(() {});
                          },
                        ),
                        itemOfHeader(
                          iconPath: 'assets/icons/drawer_feedBack.png',
                          isIconPath: true,
                          clickBoolName: isFeedbackClick,
                          text: 'Feed ',
                          onClick: () {
                            isFeedbackClick = !isFeedbackClick;
                            isFollowUpClick = false;
                            isPackageClick = false;
                            setState(() {});
                          },
                        ),
                        itemOfHeader(
                          iconPath: 'assets/icons/drawer_package.png',
                          isIconPath: true,
                          clickBoolName: isPackageClick,
                          text: 'Package',
                          onClick: () {
                            isPackageClick = !isPackageClick;
                            isFollowUpClick = false;
                            isFeedbackClick = false;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                drawerItemHeader(
                    isBool: isSettingsClick,
                    iconPath: 'assets/icons/drawer_settings.png',
                    text: 'Settings',
                    onClick: () {
                      isSettingsClick = !isSettingsClick;
                      setState(() {
                        print(isLogOutClick);
                      });
                    }),
                drawerItemHeader(
                    isBool: isLogOutClick,
                    iconPath: 'assets/icons/drawer_logOut.png',
                    text: 'Log Out',
                    onClick: () {
                      isLogOutClick = !isLogOutClick;
                      setState(() {
                        print(isLogOutClick);
                      });
                    }),
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
        padding: EdgeInsets.only(left: 20),
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
              color: isBool ? Colors.blue : Color(0xFF666666),
            ),
            SizedBox(width: 20),
            Text(
              text,
              style: small14StyleW500.copyWith(
                color: isBool ? Colors.blue : Colors.black,
              ),
            ),
            Spacer(),
            isArrow
                ? Transform.rotate(
                    angle: isBool ? 1.5708 : 0, // 90 degrees in radians
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 18,
                      color: isBool ? Colors.blue : null,
                    ),
                  )
                : SizedBox(),
            SizedBox(width: 20),
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
                  : customIcon ?? SizedBox(),
              SizedBox(width: 20),
              Text(
                text,
                style: clickBoolName ? activedDrawerItem : inActivedDrawerItem,
              ),
              Spacer(),
              isTrailling
                  ? Text(
                      '20',
                      style: clickBoolName
                          ? activedDrawerItem
                          : inActivedDrawerItem,
                    )
                  : SizedBox(),
              width20
            ],
          ),
        ),
      ),
    );
  }
}
