import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_details.dart';
import 'package:pilot_bazar_admin/re_usable_widget/re_usable_mother_widget.dart';
import 'package:pilot_bazar_admin/socket_io/socket_manager.dart';
import 'package:pilot_bazar_admin/socket_io/socket_method.dart';
import 'package:pilot_bazar_admin/socket_io/tokens.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widget/search_text_fild.dart';

class GroupChatScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  GroupChatScreen({
    super.key,
  });

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  TextEditingController searchController = TextEditingController();
  SharedPreferences? prefss;

  String? socketId;
  var socket = SocketManager().socket;
  var socketMethod = SocketMethod();

  List contacts = [];
  List contactNumber = [];
  Map<String, dynamic>? body;
  List allPerson = SocketMethod().chatList;

  pirntSocketChatToken() async {
    prefss = await SharedPreferences.getInstance();
    String token = await prefss?.getString('authorizeChatToken') ?? '';
    print("Auth Token from chat screen Local");
    print(token.toString());
    print("Auth Token from chat screen Variable");
    print(authorizeChatTokenFromOutSideVariable.toString());
    String? authToken = await prefss?.getString('token');
  }

  List? peopleList;
  List? groupList;

  callgetChatPeople() async {
    print("Groups  ");
    groupList = await socketMethod
        .getGroupChat(authorizeChatTokenFromOutSideVariable ?? '');
    print(groupList);

    peopleList = await socketMethod
        .getChatPeople(authorizeChatTokenFromOutSideVariable ?? '');
    setState(() {});
  }

  List groupUserList = [];

  @override
  void initState() {
    print("Socket Id");
    print(socket.id);
    print(authorizeChatTokenFromOutSideVariable.toString());
    callgetChatPeople();

    print("Token");
    print(authorizeChatTokenFromOutSideVariable);

    pirntSocketChatToken();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              height10,
              SearchTextFild(
                searchController: searchController,
                onSubmit: (value) async {
                  print("onSubmitted: $value");
                },
              ),
              height10,
              Expanded(
                  child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: groupList?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChattingDetailsScreen()));
                          },
                          leading: Container(
                              height: 45.05,
                              width: 40,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: Image.network(
                                groupList?[index]['avatar'],
                              )),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    groupList?[index]['room'] ?? 'None',
                                    style: small14StyleW500.copyWith(height: 0),
                                  ),
                                  const Spacer(),
                                  Text(
                                    groupList?[index]['datetime'] ?? 'None',
                                    style: small12Stylew400,
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    peopleList?[index]['phone'] ?? 'None',
                                    style: small10Style.copyWith(height: 0),
                                  ),
                                  const Spacer(),
                                  Image.asset(
                                    'assets/icons/seenMessage.png',
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      })),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 66, 66, 66),
          onPressed: () async {
            allPerson = await socketMethod
                .getChatPeople(authorizeChatTokenFromOutSideVariable ?? '');
            setState(() {});
            final result = await showModalBottomSheet(
              useSafeArea: true,
              context: context,
              isScrollControlled:
                  true, // Allows the bottom sheet to be full screen
              builder: (BuildContext context) {
                return _buildBottomSheet(context);
              },
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return DraggableScrollableSheet(
      expand:
          false, // Allows the user to drag and expand the sheet to full screen
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: SingleChildScrollView(
              primary: false,
              controller: scrollController,
              child: Stack(
                children: [
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: allPerson.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        onTap: () {
                          print(allPerson[index]['avatar']);
                          groupUserList.add(allPerson[index]['id']);
                          setState(() {});
                        },
                        leading: Container(
                            height: 45.05,
                            width: 40,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Image.network(allPerson[index]['avatar'])),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  allPerson[index]['name'] ?? 'None',
                                  style: small14StyleW500.copyWith(height: 0),
                                ),
                                const Spacer(),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  peopleList?[index]['phone'] ?? 'None',
                                  style: small10Style.copyWith(height: 0),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 20.0,
                    right: 20.0,
                    child: FloatingActionButton(
                      onPressed: () {
                        
                          Map body = {
                            "title": null,
                            "users": groupUserList
                          };
                          socketMethod.createGrop(authorizeChatTokenFromOutSideVariable??'',body);
                        
                      },
                      child: Icon(Icons.add),
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }

  inboxOrGroup(String text, Function() onTap) {
    return Container(
      child: InkWell(
        onTap: onTap,
        child: Container(
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
        ),
      ),
    );
  }
}
