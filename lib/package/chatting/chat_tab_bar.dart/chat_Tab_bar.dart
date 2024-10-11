import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_tab_bar.dart/inbox_chat.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_tab_bar.dart/group_chat.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';
import 'package:pilot_bazar_admin/provider/socket_methode_provider.dart';
import 'package:pilot_bazar_admin/screens/auth/loain_model.dart';
import 'package:pilot_bazar_admin/shimmer_effect/chat_circle_shimmer.dart';
import 'package:pilot_bazar_admin/socket_io/socket_method.dart';
import 'package:pilot_bazar_admin/socket_io/tokens.dart';
import 'package:provider/provider.dart';
import '../../../screens/auth/auth_utility.dart';
import '../../../socket_io/socket_manager.dart';

class TabChat extends StatefulWidget {
  @override
  _TabChatState createState() => _TabChatState();
}

class _TabChatState extends State<TabChat> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  LoginModel? userInfoFromPrefs;
  var socketMethod = SocketMethod();
  var socket = SocketManager();

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

  void printUserInfo() async {
    userInfoFromPrefs = await AuthUtility.getUserInfo();
    setState(() {});
   
  }

  List chatPeopleListProvider = [];
  List? activeList;

  callActivePeople() async {
    activeList?.clear();
    activeList =
        await socketMethod.getOnlineChatPeopole(messengerAPIToken ?? '');

    setState(() {});
  }

  @override
  void initState() {
    printUserInfo();
  
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    callActivePeople();
    final provider = Provider.of<SocketMethodeProvider>(context, listen: false);
    provider.getInbox(messengerAPIToken ?? '');
    SocketManager();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomerProfileBar(
                profileImagePath: userInfoFromPrefs
                        ?.payload?.merchant?.merchantInfo?.image?.name ??
                    '',
                message_icon_path: 'assets/icons/message_notification.png',
                drawer_icon_path: 'assets/icons/beside_message.png',
                merchantName:
                    userInfoFromPrefs?.payload?.merchant?.name ?? 'None',
                companyName: userInfoFromPrefs
                        ?.payload?.merchant?.merchantInfo?.companyName ??
                    "None",
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
              tabs: [
                Tab(child: inboxOrGroup('Inbox')),
                Tab(child: inboxOrGroup("Group")),
              ],
            ),
            SizedBox(
              height: 80,
              child: ListView.builder(
                itemCount: activeList?.length ?? 0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                 
                  return activeList != null
                      ? Padding(
                          padding: const EdgeInsets.all(
                              8.0), // Adjust the padding as needed
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                          activeList?[index]['image'])),
                                  Positioned(
                                      height: 75,
                                      left: 30,
                                      child: Container(
                                        height: 12,
                                        width: 12,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green,
                                        ),
                                      )),
                                ],
                              ),
                              Text(
                                (activeList?[index]?['name'] != null &&
                                        activeList?[index]['name'].length > 5)
                                    ? '${activeList?[index]['name'].substring(0, 5)}...'
                                    : activeList?[index]?['name'] ?? '',
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        )
                      : Center(
                          child: circularChat(),
                        );
                },
              ),
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
