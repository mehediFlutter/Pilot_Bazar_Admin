import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/DTO/online_people.dart';
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
import 'package:socket_io_client/socket_io_client.dart';
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
  var socket = SocketManager().socket;

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
    print("User Name is  ${userInfoFromPrefs?.name??''}");
    setState(() {});
  }

  List chatPeopleListProvider = [];
  List<OnlinePeopleDTO>? activeList;

  callOnlinePeople() async {
    activeList?.clear();
    activeList = await socketMethod.getOnlineChatPeople(
        messengerAPIToken ?? '', 'online');

    setState(() {});

  }

  @override
  void initState() {
    printUserInfo();

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });

    callOnlinePeople();

    final provider = Provider.of<SocketMethodProvider>(context, listen: false);
    provider.getInbox('people');

    SocketManager();
    socket.on(
        'joined',
        (data) async => {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(data.toString()))),
              print(data)
            });
    socket.on(
        'leaved',
        (data) async => {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(data.toString()))),
              print(data)
            });
    socket.onDisconnect((_) async {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Connection has been lost ")));

      print('Socket disconnected'); // Debug print
    });
    socket.onConnect((_) async {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Back to online")));
    });
  }

  SnackBar joinOrLeaveSnackbar(data) {
    return SnackBar(
      content: Text(data.toString()),
      duration: Duration(
          seconds: 1), // Optional: controls how long the SnackBar is visible
    );
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
                profileImagePath: 
                // userInfoFromPrefs
                //         ?.payload?.merchant?.merchantInfo?.image?.name ??
                    '',
                notification_image_path: 'assets/icons/sync.png',
                drawer_icon_path: 'assets/icons/beside_message.png',
                merchantName:
                    userInfoFromPrefs?.name ?? 'None',
                companyName: userInfoFromPrefs
                        ?.phone ??
                    "None",
                onTapFunction: () {},
                chatTap: () async {
                  await socketMethod.fetchContacts();
                  await socketMethod.postPhoneNumber();
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
                                          activeList?[index].image ?? '')),
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
                                (activeList?[index].name != null &&
                                        (activeList?[index].name?.length ?? 0) >
                                            5)
                                    ? '${activeList?[index].name?.substring(0, 5)}...'
                                    : activeList?[index].name ?? '',
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
