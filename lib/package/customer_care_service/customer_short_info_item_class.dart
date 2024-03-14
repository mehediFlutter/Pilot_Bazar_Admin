import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';

class CustomerShortInfoItemClass extends StatefulWidget {
  const CustomerShortInfoItemClass({super.key});

  @override
  State<CustomerShortInfoItemClass> createState() =>
      _CustomerShortInfoItemClassState();
}

class _CustomerShortInfoItemClassState
    extends State<CustomerShortInfoItemClass> {
  Color scheduleColor = Colors.black;
  Color messageColor = Colors.black;
  Color infoColor = Colors.black;
  Row containerDetailsHeaderTalkWhatsApp(String header) {
    return Row(
      children: [
        width10,
        Image.asset('assets/icons/small_arror.png'),
        width10,
        Text(
          header,
          style: small12Style,
        ),
        Spacer(),
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              border: Border.all(color: searchBarBorderColor),
              borderRadius: BorderRadius.circular(4)),
          child: Icon(
            Icons.add,
            color: Colors.black,
            size: 15,
          ),
        ),
        width10
      ],
    );
  }

  Row containerDetailsHeaderNeedToCall(String header) {
    return Row(
      children: [
        width10,
        Image.asset('assets/icons/small_arror.png'),
        width10,

        Text(
          header,
          style: small12Style,
        ),
        //  Spacer(),
        width10,
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              border: Border.all(color: searchBarBorderColor),
              borderRadius: BorderRadius.circular(4)),
          child: Icon(
            Icons.phone,
            color: Colors.black,
            size: 13,
          ),
        ),
        width10
      ],
    );
  }

  int selectedIndex = 0;

  onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  int ScheduleMessageInfoSelectIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: borderRadious10,
            border: Border.all(color: searchBarBorderColor)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  const SizedBox(height: 15),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        borderRadius: borderRadious10,
                        border: Border.all(color: searchBarBorderColor)),
                    child: Image.asset('assets/images/jon_profile.png'),
                  ),
                ),
                Column(
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
                Spacer(),
                Icon(
                  Icons.more_horiz,
                  color: Color(0xFF959090),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
              child: Divider(
                color: searchBarBorderColor,
                thickness: 1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        messageColor = Colors.black;
                        infoColor = Colors.black;
                        scheduleColor = Colors.blue;
                        ScheduleMessageInfoSelectIndex = 0;
                        setState(() {});
                      },
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: searchBarBorderColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/icons/schedule.png',
                              color: scheduleColor,
                            ),
                            Text(
                              "Schedule",
                              style:
                                  small12Style.copyWith(color: scheduleColor),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        messageColor = Colors.blue;
                        scheduleColor = Colors.black;
                        infoColor = Colors.black;
                        ScheduleMessageInfoSelectIndex = 1;

                        setState(() {});
                      },
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: searchBarBorderColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/icons/message.png',
                              color: messageColor,
                            ),
                            Text(
                              "Message",
                              style: small12Style.copyWith(color: messageColor),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        infoColor = Colors.blue;
                        messageColor = Colors.black;
                        scheduleColor = Colors.black;
                        ScheduleMessageInfoSelectIndex = 2;

                        setState(() {});
                      },
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: searchBarBorderColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/icons/info.png',
                              color: infoColor,
                            ),
                            Text("Info",
                                style: small12Style.copyWith(color: infoColor))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // if(ScheduleMessageInfoSelectIndex ==0) ...{
            //   ClassOne();
            // }
            // else if (ScheduleMessageInfoSelectIndex ==1)...{
            //   ClassTwo();
            // }
            // else ...{
            //   ClassThree();
            // }

          ScheduleMessageInfoSelectIndex==0 ?  Divider(color: Colors.black,):SizedBox(),

          ScheduleMessageInfoSelectIndex==0 ?  Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                width10,
                Tabs(
                    text: 'Today',
                    isSelected: selectedIndex == 0,
                    onTap: () {
                      onTabTapped(0);
                    }),
                width10,
                Tabs(
                    text: 'All',
                    isSelected: selectedIndex == 1,
                    onTap: () {
                      onTabTapped(1);
                    }),
              ],
            ):SizedBox(),
         
           ScheduleMessageInfoSelectIndex==0 ? Divider(
              color: searchBarBorderColor,
            ):SizedBox(),
         ScheduleMessageInfoSelectIndex==0 ?   containerDetailsHeaderTalkWhatsApp("Talk Through Whats app"):SizedBox(),
          ScheduleMessageInfoSelectIndex==0 ?  Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.green),
                      ),
                      width10,
                      Text(
                        "He is very interested",
                        style: small12Style,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.green),
                      ),
                      width10,
                      Expanded(
                          child: Text(
                        "He will let us khow after discuss with his family",
                        style: small12Style,
                        overflow: TextOverflow.ellipsis,
                      )),
                    ],
                  ),
                ],
              ),
            ):SizedBox(),
            height10,
           ScheduleMessageInfoSelectIndex==0 ? containerDetailsHeaderNeedToCall('Need To Call 12 May 2024'):SizedBox(),
          ScheduleMessageInfoSelectIndex==0 ?  Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.green),
                      ),
                      width10,
                      Expanded(
                        child: Text(
                          "After Call i know that he will visite our showroom fter Call i know that he will visite our showroomfter Call i know that he will visite our showroom",
                          style: small12Style,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ):SizedBox(),
          //  const SizedBox(height: 15)
          ],
        ),
      ),
    );
  }
}

class Tabs extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function onTap;

  const Tabs({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double underlineWidth = isSelected ? 40.0 : 0.0; // Initial underline width
    if (text == 'All') {
      underlineWidth =
          isSelected ? 20.0 : 0.0; // Update underline width for 'All' tab
    }

    return GestureDetector(
      onTap: () => onTap(),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? Colors.blue : Colors.black,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4), // Adding gap between text and underline
          Container(
            height: 2,
            width: underlineWidth, // Dynamic width for underline
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
