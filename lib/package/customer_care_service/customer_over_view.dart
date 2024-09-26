import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_font_screen.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_short_info_item_class.dart';
import 'package:pilot_bazar_admin/package/customer_requirement_store/customer_personal_info.dart';
import 'package:pilot_bazar_admin/re_usable_widget/re_usable_mother_widget.dart';
import 'package:pilot_bazar_admin/screens/auth/auth_utility.dart';
import 'package:pilot_bazar_admin/screens/auth/loain_model.dart';
import 'package:pilot_bazar_admin/screens/auth/login_screen.dart';
import 'package:pilot_bazar_admin/theme_manager.dart';

class CustomerOverView extends StatefulWidget {
  final ValueNotifier<ThemeMode> notifier;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  CustomerOverView({super.key, required this.notifier});

  @override
  State<CustomerOverView> createState() => _CustomerOverViewState();
}

class _CustomerOverViewState extends State<CustomerOverView> {
  @override
  final TextEditingController _controller = TextEditingController();
  List customerList = [
    'customer1',
    'customer2',
    'customer3',
    'customer4',
    'customer5',
    'customer6',
    'customer7'
  ];
  List<Map<String, dynamic>> items = [
    {'name': 'Mohon Lal', 'price': '80000 tk'},
    {'name': 'Abdur Rahman', 'price': '850000 tk'},
    {'name': 'Rubel Hussain', 'price': '80430 tk'},
    {'name': 'Taimur Haque', 'price': '804540 tk'},
    {'name': 'Naim Shekh', 'price': '8004243 tk'},
    {'name': 'Dulal Rahman', 'price': '853400 tk'},
    {'name': 'Abdur Rahman', 'price': '80000 tk'},
    {'name': 'Mehedi', 'price': '80040 tk'},
    {'name': 'Shah Alam', 'price': '785455 tk'},
    {'name': 'Mr Hassan', 'price': '54000 tk'},
  ];
  List<Map<String, dynamic>> _filteredItems = [];

  var userInfo;

  loadUserInfo() async {
    LoginModel user = await AuthUtility.getUserInfo();

    userInfo = user.toJson();
    print(userInfo.toString());
    setState(() {});
  }

  @override
  void initState() {
    _filteredItems = List<Map<String, dynamic>>.from(items); // Copy the list
    super.initState();

    loadUserInfo();
  }

  void _filterList(String searchText) {
    setState(() {
      _filteredItems = items
          .where((item) =>
              item['name'].toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ReUsableMotherWidget(notifier: widget.notifier, children: [
      Builder(builder: (context) {
        return CustomerProfileBar(
          profileImagePath: userInfo?['payload']?['merchant']?['merchant_info']
                  ?['image']?['name'] ??
              '',
          message_icon_path: 'assets/icons/message_notification.png',
          drawer_icon_path: 'assets/icons/beside_message.png',
          companyName: userInfo?['payload']?['merchant']?['name'] ?? 'None',
          phoneNumber: userInfo?['payload']?['merchant']?['merchant_info']
                  ['company_name'] ??
              "None",
          onTapFunction: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomerPersonalInfo(
                          notifier: widget.notifier,
                        )));
          },
          chatTap: () {
            print("notificaiton tap");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatFontScreen(
                          notifier: widget.notifier,
                        )));
          },
          // drawerTap: () {
          //   Scaffold.of(context).openDrawer();

          // },
        );
      }),
      height5,
      height5,

      Container(
        height: 40,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadious20,
        ),
        child: TextField(
          cursorColor: Colors.black,
          cursorWidth: 1.2,
          controller: _controller,
          onChanged: _filterList,
          style: Theme.of(context).textTheme.bodySmall,
          cursorHeight: 15,
          decoration: InputDecoration(
              enabledBorder: searchBarBorder,
              focusedBorder: searchBarBorder,
              contentPadding: const EdgeInsets.only(
                top: 8,
              ),
              hintText: "Search",
              hintStyle: Theme.of(context).textTheme.bodySmall,
              prefixIcon: const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 15,
                ),
              )),
        ),
      ),
      height10,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 144,
            height: 38,
            decoration: BoxDecoration(
                border: Border.all(color: allCustomerBorderAndTextColor),
                borderRadius: borderRadious10),
            child: Center(
                child: Text(
              'All Customer',
              style: small10Stylew500.copyWith(
                  color: allCustomerBorderAndTextColor),
            )),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CustomerPersonalInfo(notifier: widget.notifier)));
            },
            child: Container(
              height: 30,
              width: 35,
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.onSurface),
                  borderRadius: borderRadious8),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CustomerPersonalInfo(notifier: widget.notifier)));
                },
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 10,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      //   height10,

      // IconButton(
      //     onPressed: () {
      //       Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //               builder: (context) => CustomerRequirementInputFilds()));
      //     },
      //     icon: Icon(Icons.add)),
      //   SizedBox(height: size.height / 20),
      height10,
      Expanded(
        child: ListView.builder(
          itemCount: _filteredItems.length,
          itemBuilder: (context, index) {
            return const CustomerShortInfoItemClass();
            //  return ItemClass(item: _filteredItems[index]);
          },
        ),
      ),
    ]);
  }
}
