import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/notification/notification_page.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_font_screen.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/search/search.dart';
import 'package:pilot_bazar_admin/profile/profile.dart';
import 'package:pilot_bazar_admin/package/product_&_item/item_class.dart';

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
    return SafeArea(
        child: Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          children: [
            CustomerProfileBar(
              profileImagePath: 'assets/images/small_profile.png',
              NotificationIconPath: 'assets/icons/message_notification.png',
              onTapFunction: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              notificationTap: () {
                print("notificaiton tap");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatFontScreen()));
              },
            ),
            height5,
            height5,

//             Container(
//   width: 200, // Example width
//   height: 50, // Example height
//   color: Colors.blue, // Example background color
//   child: Center(
//     child: Text(
//       'This is a long text that will overflow and display ellipsis when it exceeds the container width.',
//       style: TextStyle(
//         fontSize: 20, // Set the font size
//         color: Colors.white, // Example text color
//       ),
//       overflow: TextOverflow.ellipsis, // Set overflow behavior
//     ),
//   ),
// ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 25),
              child: Container(
                height: 30,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFEDEDED),
                  borderRadius: BorderRadious20,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: TextField(
                    cursorColor: Colors.black,
                    cursorWidth: 1.2,
                    // onTap: () {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => SearchPage()));
                    // },
                    controller: _controller,
                    onChanged: _filterList,
                    style: Theme.of(context).textTheme.bodySmall,
                    cursorHeight: 15,
                    decoration: InputDecoration(
                      
                        hintText: "Search",
                        hintStyle: Theme.of(context).textTheme.bodySmall,
                        border: InputBorder.none,
                        
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 15,
                          ),
                        )),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height / 20),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredItems.length,
                itemBuilder: (context, index) {
                  return ItemClass(item: _filteredItems[index]);
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
