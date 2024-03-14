import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_short_info_item_class.dart';

class ScheduleDetailsClass extends StatefulWidget {
  const ScheduleDetailsClass({super.key});

  @override
  State<ScheduleDetailsClass> createState() => _ScheduleDetailsClassState();
}

class _ScheduleDetailsClassState extends State<ScheduleDetailsClass> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
        ),
        Divider(
          color: Colors.black,
        ),
        containerDetailsHeaderTalkWhatsApp("Talk Through Whats app"),
        Padding(
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
        ),
        height10,
        containerDetailsHeaderNeedToCall('Need To Call 12 May 2024'),
        Padding(
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
        ),
      ],
    );
  }
}
