import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/notification/notification_page.dart';
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
            SizedBox(height: size.height / 20),
            ListTile(
              leading: Chatting_profile_with_green_tolu(),
           title: Text('Shah Alam'),
            ),
            
          ],
        ),
      ),
    ));
  }
}

class Chatting_profile_with_green_tolu extends StatefulWidget {
  final bool isActive;
  const Chatting_profile_with_green_tolu({
    super.key, this.isActive=true,
  });

  @override
  State<Chatting_profile_with_green_tolu> createState() => _Chatting_profile_with_green_toluState();
}

class _Chatting_profile_with_green_toluState extends State<Chatting_profile_with_green_tolu> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
       Container(
            height: 45.05,
            width: 40,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Image.asset('assets/images/chatting_image.png')),
     
             widget.isActive? Container(
              margin: EdgeInsets.only(left: 30,top: 26),
          height: 11,
          width: 11,
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black,),
          child:  Image.asset('assets/icons/green_tolu.png'),
         
        ):SizedBox(),
       
      ],
    );
  }
}
