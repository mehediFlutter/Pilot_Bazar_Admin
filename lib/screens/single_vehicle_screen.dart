import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_font_screen.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';
import 'package:pilot_bazar_admin/package/customer_requirement_store/customer_personal_info.dart';
import 'package:pilot_bazar_admin/package/drawer/drawer.dart';
import 'package:pilot_bazar_admin/re_usable_widget/re_usable_mother_widget.dart';
import 'package:pilot_bazar_admin/screens/auth/auth_utility.dart';
import 'package:pilot_bazar_admin/screens/auth/loain_model.dart';
import 'package:pilot_bazar_admin/widget/item.dart';
import 'package:pilot_bazar_admin/widget/search_text_fild.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';

class SingleVehicleScreen extends StatefulWidget {
  const SingleVehicleScreen({super.key});

  @override
  State<SingleVehicleScreen> createState() => _SingleVehicleScreenState();
}

class _SingleVehicleScreenState extends State<SingleVehicleScreen> {
  @override
  Map<String, dynamic>? userInfo;
  TextEditingController searchController = TextEditingController();

  loadUserInfo() async {
    LoginModel user = await AuthUtility.getUserInfo();
    userInfo = user.toJson();
    setState(() {});
  }

  void initState() {
    loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Builder(builder: (context) {
                return CustomerProfileBar(
                  profileImagePath: userInfo?['payload']?['merchant']
                          ?['merchant_info']?['image']?['name'] ??
                      '',
                  message_icon_path: 'assets/icons/message_notification.png',
                  drawer_icon_path: 'assets/icons/beside_message.png',
                  merchantName:
                      userInfo?['payload']?['merchant']?['name'] ?? 'None',
                  companyName: userInfo?['payload']?['merchant']
                          ?['merchant_info']['company_name'] ??
                      "None",

                  // onTapFunction: () {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => CustomerPersonalInfo()));
                  // },
                  // chatTap: () {
                  //   print("notificaiton tap");
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => ChatFontScreen()));
                  // },
                  // drawerTap: () {
                  //   Scaffold.of(context).openDrawer();

                  // },
                );
              }),
              SearchTextFild(
                searchController: searchController,
              ),
              height20,
              Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Item());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
