import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/notification/notification_page.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_details_leading_profile.dart';
import 'package:pilot_bazar_admin/package/chatting/exackly_chattine_lead_imag.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';
import 'package:pilot_bazar_admin/profile/profile.dart';

class ChattingDetailsScreen extends StatefulWidget {
  const ChattingDetailsScreen({super.key});

  @override
  State<ChattingDetailsScreen> createState() => _ChattingDetailsScreenState();
}

class _ChattingDetailsScreenState extends State<ChattingDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          //  crossAxisAlignment: CrossAxisAlignment.start,
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
                    cursorColor: Colors.black,
                    cursorWidth: 1.2,

                    // controller: _controller,
                    // onChanged: _filterList,
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
            SizedBox(
              height: size.height / 30,
            ),
            ListTile(
              leading: ChattingDetailsLeading(
                  detailsChatLeadingPath: 'assets/images/chatting_image.png'),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Shah Alam",
                    style: small12Style.copyWith(
                        fontWeight: FontWeight.w900, fontFamily: 'Roboto'),
                  ),
                  Text(
                    "Client",
                    style: small10Style.copyWith(
                        fontWeight: FontWeight.w300, fontFamily: 'Roboto'),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.phone_callback,
                    color: Colors.green,
                    size: 15,
                  ),
                  width10,
                  Icon(
                    Icons.video_call,
                    color: Colors.green,
                    size: 15,
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height / 30),
            message(Alignment.topLeft, 'assets/images/chatting_image.png',
                "Hello There how are you? I hope you are well",false),
            message(Alignment.topRight, "assets/images/chatting_image.png",
                "Yes I am fine what about you?",true),
                message(Alignment.topLeft, 'assets/images/chatting_image.png',
                "Hello There how are you? I hope you are well",false),
                 message(Alignment.topRight, "assets/images/chatting_image.png",
                "Yes I am fine what about you?",true),
                
          ],
        ),
      ),
    ));
  }

  Container message(
      Alignment setAlign, String detailsChatLeadingPath, chatText, bool isRight) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: setAlign,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
        isRight? SizedBox(): Container(
            child: ExacklyChatLeading(
              detailsChatLeadingPath: detailsChatLeadingPath,
            ),
          ),
          width10,
          Material(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
                bottomLeft:isRight? Radius.circular(10):Radius.zero,
              bottomRight:isRight? Radius.zero:Radius.circular(10),
            ),
            elevation: 4,
            child: Container(
              padding: EdgeInsets.all(5),
              width: 150,
              decoration: BoxDecoration(),
              child: Text(chatText),
            ),
          ),
          isRight?  Container(
            child: ExacklyChatLeading(
              detailsChatLeadingPath: detailsChatLeadingPath,
            ),
          ): SizedBox()
        ],
      ),
    );
  }
}
