import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/notification/notification_page.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_details.dart';
import 'package:pilot_bazar_admin/package/chatting/chatting_font_person.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';
import 'package:pilot_bazar_admin/profile/profile.dart';

class ChatFontScreen extends StatefulWidget {
  const ChatFontScreen({super.key});

  @override
  State<ChatFontScreen> createState() => _ChatFontScreenState();
}

class _ChatFontScreenState extends State<ChatFontScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
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
                        builder: (context) => NotificaitonScreen()));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 25),
              child: Container(
                height: 30,
                width: double.infinity,
                decoration: const BoxDecoration(
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
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(top: 4),
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
            Expanded(child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChattingDetailsScreen()));
                },
                leading: Chatting_profile_with_green_tolu(),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shah Alam',
                      style: small12Style.copyWith(height: 0),
                      
                    ),
                    Row(
                  children: [
                    Text("You: ",style: small10Style.copyWith(height: 0),),
                    Container(
                        padding: EdgeInsets.zero,
                        width: 65,
                        child: Text(
                          "Hello There is Any Car",
                          style: small10Style.copyWith(height: 0),
                          overflow: TextOverflow.ellipsis,
                        )),
                  ],
                ),
                  ],
                ),
             
              );
            }))
          ],
        ),
      ),
    ));
  }
}
