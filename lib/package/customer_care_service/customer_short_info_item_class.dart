import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';

class CustomerShortInfoItemClass extends StatefulWidget {
  const CustomerShortInfoItemClass({super.key});

  @override
  State<CustomerShortInfoItemClass> createState() => _CustomerShortInfoItemClassState();
}

class _CustomerShortInfoItemClassState extends State<CustomerShortInfoItemClass> {
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
  @override
  Widget build(BuildContext context) {
    return   Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: borderRadious10,
                border: Border.all(color: searchBarBorderColor)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
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
                        Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                              border: Border.all(color: searchBarBorderColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset('assets/icons/schedule.png'),
                              Text(
                                "Schedule",
                                style: small12Style.copyWith(
                                    color: allCustomerBorderAndTextColor),
                              )
                            ],
                          ),
                        ),
                      ],
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset('assets/icons/message.png'),
                              Text("Schedule", style: small12Style)
                            ],
                          ),
                        ),
                      ],
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset('assets/icons/info.png'),
                              Text("Schedule", style: small12Style)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(color: searchBarBorderColor),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    width10,
                    Text('Today', style: small14Style),
                    width10,
                    Text('All', style: small14Style),
                  ],
                ),
                Divider(
                  color: searchBarBorderColor,
                ),
                containerDetailsHeaderTalkWhatsApp("Talk Through Whats app"),
                Padding(
                  padding: const EdgeInsets.only(left: 45),
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
                  padding: const EdgeInsets.only(left: 45),
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
                              "After Call i know that he will visite our showroom",
                              style: small12Style,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15)
              ],
            ),
          );
  }

}