import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/notification/notification_page.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_font_screen.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/search/search.dart';
import 'package:pilot_bazar_admin/package/customer_requirement_store/customer_requirement_input_fields_screen.dart';
import 'package:pilot_bazar_admin/profile/profile.dart';
import 'package:pilot_bazar_admin/package/product_&_item/item_class.dart';
import 'package:pilot_bazar_admin/re_usable_widget/re_usable_mother_widget.dart';

class CustomerListTile extends StatefulWidget {
  const CustomerListTile({super.key});

  @override
  State<CustomerListTile> createState() => _CustomerListTileState();
}

class _CustomerListTileState extends State<CustomerListTile> {
  @override
  TextEditingController _controller = TextEditingController();
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
  @override
  void initState() {
    _filteredItems = List<Map<String, dynamic>>.from(items); // Copy the list
    super.initState();
  }

  void _filterList(String searchText) {
    setState(() {
      _filteredItems = items
          .where((item) =>
              item['name'].toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ReUsableMotherWidget(childred: [
      CustomerProfileBar(
        profileImagePath: 'assets/images/small_profile.png',
        message_icon_path: 'assets/icons/message_notification.png',
        beside_message_icon_path: 'assets/icons/beside_message.png',
        onTapFunction: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProfilePage()));
        },
        notificationTap: () {
          print("notificaiton tap");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ChatFontScreen()));
        },
        besideMessageTap: () {
          print("notificaiton tap");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ChatFontScreen()));
        },
      ),
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
          Container(
            height: 30,
            width: 35,
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
                border: Border.all(color: searchBarBorderColor),
                borderRadius: borderRadious8),
            child: Container(
              height: 10,
              width: 10,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 10,
              ),
            ),
          ),
        ],
      ),
      height10,
      Container(
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: borderRadious10,
            border: Border.all(color: searchBarBorderColor)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        borderRadius: borderRadious10,
                        border: Border.all(color: searchBarBorderColor)),
                    child: Image.asset('assets/images/jon_profile.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Siam Ahmed Jon",
                        style: small14Style,
                      ),
                      Text(
                        "+8801969944400",
                        style: small10Style,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.more_horiz,
                    color: Color(0xFF959090),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
              child: Divider(
                color: searchBarBorderColor,
                thickness: 1,
              ),
            ),
            Row(
              children: [         
                Container(
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: searchBarBorderColor),
                      borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Image.asset(''),
                          Text("Schedule",style: small12Style.copyWith(color: allCustomerBorderAndTextColor),)
                        ],
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
      IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomerRequirementInputFilds()));
          },
          icon: Icon(Icons.add)),
      SizedBox(height: size.height / 20),
      Expanded(
        child: ListView.builder(
          itemCount: _filteredItems.length,
          itemBuilder: (context, index) {
            return ItemClass(item: _filteredItems[index]);
          },
        ),
      ),
    ]);
  }
}
