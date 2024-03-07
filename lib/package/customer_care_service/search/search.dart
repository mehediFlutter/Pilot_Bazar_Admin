import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/notification/notification_page.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';
import 'package:pilot_bazar_admin/profile/profile.dart';
import 'package:pilot_bazar_admin/re_usable_widget/item_class.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller = TextEditingController();

List<Map<String, dynamic>> items = [
  {'name': 'Banana','price':'80000 tk'},
  {'name': 'Orange','price':'850000 tk'},
  {'name': 'Mango','price':'80430 tk'},
  {'name': 'Pineapple','price':'804540 tk'},
  {'name': 'Apple','price':'8004243 tk'},
  {'name': 'Banana','price':'853400 tk'},
  {'name': 'Orange','price':'80000 tk'},
  {'name': 'Mango','price':'80040 tk'},
  {'name': 'Pineapple','price':'785455 tk'},
  {'name': 'Apple','price':'54000 tk'},
];
List<Map<String, dynamic>> _filteredItems = [];

@override
void initState() {
  _filteredItems = List<Map<String, dynamic>>.from(items); // Copy the list
  print('length of items');
  print(items.length);
}

void _filterList(String searchText) {
  setState(() {
    _filteredItems = items
        .where((item) => item['name']
            .toLowerCase()
            .contains(searchText.toLowerCase()))
        .toList();
  });
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Column(
            children: [
              CustomerProfileBar(
                profileImagePath: 'assets/images/small_profile.png',
                onTapFunction: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
                notificationTap: () {
                  print("notificaiton tap");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificaitonScreen()));
                },
              ),
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
      ),
    );
  }
}
