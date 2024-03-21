import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';

class MyDrawerPractice extends StatefulWidget {
  const MyDrawerPractice({
    Key? key,
  }) : super(key: key);

  @override
  State<MyDrawerPractice> createState() => _MyDrawerPracticeState();
}

class _MyDrawerPracticeState extends State<MyDrawerPractice> {
  bool isCustomerClick = false;
  bool isCreateClick = false;
  bool isViewClick = false;
  int numberOfDrawerItemHeaderChildWidgets = 1;
  double drawerItemHeaderChildHeight = 50;
  double totalHeight = 50;

  calculateHeight() async {
    if (isCustomerClick) {
      totalHeight = await drawerItemHeaderChildHeight *
          numberOfDrawerItemHeaderChildWidgets;
      setState(() {});
      print(totalHeight);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                drawerItemHeader(
                  onClick: () {
                    setState(() {
                      isCustomerClick = !isCustomerClick;
                    
                    });
                  },
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: isCustomerClick ? 100 : 0,
                  child: isCustomerClick
                      ? Column(
                          children: [
                            drawerItemHeaderChild(
                           
                              viewClick: () {
                                setState(() {
                                  isCreateClick = !isCreateClick;
                                  isViewClick = false;
                                  print("1st method");
                                });
                              },
                            ),
                            drawerItemHeaderChild(
                              viewClick: () async {
                                setState(() {
                                  print("2nd method");
                                });
                              },
                            ),
                            drawerItemHeaderChild(
                              viewClick: () async {
                                setState(() {
                                  print("3rd method");
                                });
                              },
                            ),
                          ],
                        )
                      : SizedBox(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerItemHeader({required Function() onClick}) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.only(left: 20),
        width: double.infinity,
        height: 59,
        decoration: BoxDecoration(
          borderRadius: borderRadious10,
          border: isCustomerClick ? Border.all(color: Colors.blue) : null,
        ),
        child: Row(
          children: [
            Icon(
              Icons.person,
              color: isCustomerClick ? Colors.blue : Color(0xFF666666),
            ),
            SizedBox(width: 20),
            Text(
              'Customers',
              style: TextStyle(
                color: isCustomerClick ? Colors.blue : Colors.black,
              ),
            ),
            Spacer(),
            Transform.rotate(
              angle: isCustomerClick ? 1.5708 : 0, // 90 degrees in radians
              child: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 18,
                color: isCustomerClick ? Colors.blue : null,
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }

  Widget drawerItemHeaderChild(
      {required Function() viewClick }) {
    setState(() {});
    return Expanded(
      child: InkWell(
        onTap: viewClick,
        child: Row(
          children: [
            Icon(
              Icons.person,
              color: isViewClick
                  ? activeDrawerItemIconColor
                  : inActiveDrawerItemIconColor,
            ),
            SizedBox(width: 20),
            Text(
              'View',
              style: isViewClick ? activedDrawerItem : inActivedDrawerItem,
            ),
            Spacer(),
            Text(
              '20',
              style: inActivedDrawerItem,
            )
          ],
        ),
      ),
    );
  }
}
