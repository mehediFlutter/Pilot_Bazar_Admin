import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/notification/notification_page.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';
import 'package:pilot_bazar_admin/profile/profile.dart';

class CustomerListTile extends StatefulWidget {
  const CustomerListTile({super.key});

  @override
  State<CustomerListTile> createState() => _CustomerListTileState();
}

class _CustomerListTileState extends State<CustomerListTile> {
  @override
  List customerList = [
    'customer1',
    'customer2',
    'customer3',
    'customer4',
    'customer5',
    'customer6',
    'customer7'
  ];
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: whiteColor,
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
            height5,
            height5,
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
            SizedBox(height: size.height / 15),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 25),
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        height: 45,
                        width: 45,
                        child: Center(
                            child: Image.asset('assets/images/customer_1.png')),
                      ),
                    ),
                    width5,
                    width5,
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mohon Lal",
                            overflow: TextOverflow.visible,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          Text("+8801969944400",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(height: 0)),
                          Text("Brand : Toyota",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(height: 0)),
                          Text("Budget : 850000 tk",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(height: 0)),
                        ],
                      ),
                    ),
                    width5,
                    width5,
                    horizontalLine,
                    width5,
                    width5,
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Seriousness : 60%",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(height: 0)),
                          Text("Level : VVIP",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(height: 0)),
                          Text("Profession : Business Man",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(height: 0)),
                          Text("Budget : 850000 tk",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(height: 0)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
              Expanded(
              child: ListView.builder(
               primary: false,
               // shrinkWrap: false,
                 scrollDirection: Axis.vertical,
                  itemCount: customerList.length,
                  itemBuilder: (context, index) {
                    return Text(customerList[index]);
                  }),
            ),
          
          ],
        ),
      ),
    ));
  }
}
