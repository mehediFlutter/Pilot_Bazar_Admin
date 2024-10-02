import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_short_info_item_class.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/schedule/tab_today_all.dart';

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
          style: small12Stylew500,
        ),
        const Spacer(),
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              border: Border.all(color: searchBarBorderColor),
              borderRadius: BorderRadius.circular(4)),
          child: const Icon(
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
          style: small12Stylew500,
        ),
        //  Spacer(),
        width10,
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              border: Border.all(color: searchBarBorderColor),
              borderRadius: BorderRadius.circular(4)),
          child: const Icon(
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
        //  Divider(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            width10,
            Tabs(
                text: 'Today',
                isSelected: selectedIndex == 0,
                onTap: () {
                  onTabTapped(0);
                  print(selectedIndex);
                }),
            width10,
            Tabs(
                text: 'All',
                isSelected: selectedIndex == 1,
                onTap: () {
                  onTabTapped(1);
                  print(selectedIndex);
                }),
          ],
        ),
        const Divider(
          height: 0,
          color: searchBarBorderColor,
        ),
        height10,

        selectedIndex == 0
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  containerDetailsHeaderTalkWhatsApp("Talk Through Whats app"),
                  ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: ((context, index) {
                        return detailsSmallArrow('He is very interested');
                      })),
                  height10,
                  containerDetailsHeaderNeedToCall('Need To Call 12 May 2024'),
                  detailsSmallArrow(
                      'He will let us khow after discuss with his family'),
                ],
              )
            : const Text("hello")
      ],
    );
  }

  Padding detailsSmallArrow(String text1) {
    return Padding(
      padding: const EdgeInsets.only(left: 35),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.subdirectory_arrow_right_rounded,
                color: syncIconColor,
                size: 15,
              ),
              Expanded(
                child: Text(
                  text1,
                  style: small12Stylew500,
                ),
              ),
            ],
          ),
          // Row(
          //   children: [
          //      Icon(Icons.arrow_forward,size: 12,color: Colors.grey,),
          //     width10,
          //     Expanded(
          //         child: Text(
          //       text2,
          //       style: small12Style,
          //     //  overflow: TextOverflow.ellipsis,
          //     )),
          //   ],
          // ),
        ],
      ),
    );
  }
}
