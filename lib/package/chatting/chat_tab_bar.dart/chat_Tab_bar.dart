import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_tab_bar.dart/chat_details.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_tab_bar.dart/inbox_chat.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_tab_bar.dart/group_chat.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';

class TabChat extends StatefulWidget {
  @override
  _TabChatState createState() => _TabChatState();
}

class _TabChatState extends State<TabChat> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  inboxOrGroup(String text) {
    return Container(
      height: 40,
      width: 118,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(30)),
      child: Center(
        child: Text(
          text,
          style: small14StyleW500.copyWith(color: Colors.blue),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        // Forces the widget to rebuild when the tab changes
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomerProfileBar(
                profileImagePath: 'assets/images/small_profile.png',
                message_icon_path: 'assets/icons/message_notification.png',
                drawer_icon_path: 'assets/icons/beside_message.png',
                onTapFunction: () {},
                chatTap: () {
                  // print("notificaiton tap");
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ChattingDetailsScreen()));
                },
              ),
            ),
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black,
              tabs:  [
                Tab(
                  child: inboxOrGroup('Inbox')
                ),
                Tab(
                  child: inboxOrGroup("Group")
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [InboxChatScreen(), GroupChatScreen()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
