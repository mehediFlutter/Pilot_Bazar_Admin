import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/info/info_class.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/schedule/schedule_class.dart';

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
  bool selectSchedule = false;
  bool selectMessage = false;
  bool selectInfo = false;

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
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: borderRadious10,
            border: Border.all(color: searchBarBorderColor)),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
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

                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Siam Ahmed Jon",
                      style: small14StyleW500,
                    ),
                    Text(
                      "8801969944400",
                      style: small10Style,
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(
                  Icons.more_horiz,
                  color: Color(0xFF959090),
                ),
                //   SizedBox(height: 10,)
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
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

                        ScheduleMessageInfoSelectIndex = 0;
                        selectSchedule = !selectSchedule;
                        selectInfo = false;
                        selectMessage = false;
                        selectSchedule
                            ? scheduleColor = Colors.blue
                            : scheduleColor = Colors.black;
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
                              style: small12Stylew500.copyWith(
                                  color: scheduleColor),
                            ),
                            //   selectSchedule? Icon(Icons.arrow_drop_down_sharp):Icon(Icons.arrow_drop_up_sharp)
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
                        scheduleColor = Colors.black;
                        infoColor = Colors.black;
                        ScheduleMessageInfoSelectIndex = 1;
                        selectMessage = !selectMessage;
                        selectSchedule = false;
                        selectInfo = false;

                        selectMessage
                            ? messageColor = Colors.blue
                            : messageColor = Colors.black;

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
                              style: small12Stylew500.copyWith(
                                  color: messageColor),
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
                        messageColor = Colors.black;
                        scheduleColor = Colors.black;
                        ScheduleMessageInfoSelectIndex = 2;
                        selectInfo = !selectInfo;
                        selectSchedule = false;
                        selectMessage = false;
                        selectInfo
                            ? infoColor = Colors.blue
                            : infoColor = Colors.black;

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
                                style:
                                    small12Stylew500.copyWith(color: infoColor))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const Divider(
              color: searchBarBorderColor,
            ),

            if (selectSchedule == true) ...{
              const ScheduleDetailsClass(),
            } else if (selectInfo == true) ...{
              const InfoDetailsClass(widthside: double.infinity),
            }

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
    super.key,
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
          const SizedBox(height: 4), // Adding gap between text and underline
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
