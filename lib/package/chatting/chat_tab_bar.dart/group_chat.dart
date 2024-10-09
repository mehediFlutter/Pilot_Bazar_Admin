import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_tab_bar.dart/chat_details.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_tab_bar.dart/send_message_text_fild.dart';
import 'package:pilot_bazar_admin/shimmer_effect/chat_front_screen_shimmer.dart';
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
  FocusNode myFocusNode = FocusNode();

  List contacts = [];
  List contactNumber = [];
  Map<String, dynamic>? body;
  List allPerson = SocketMethod().chatList;
  bool isSelectForCreateGroup = false;
  bool isSelected = false;

  pirntSocketChatToken() async {
    prefss = await SharedPreferences.getInstance();
    String token = await prefss?.getString('authorizeChatToken') ?? '';
    print("Auth Token from chat screen Local");
    print(token.toString());
    print("Auth Token from chat screen Variable");
    print(messengerAPIToken.toString());
    print("From Socket Socket Id");
    print(socket.id);
    String? authToken = await prefss?.getString('token');
  }

  List? groupList;
  callgetChatPeople() async {
    groupList?.clear();

    groupList = await socketMethod.getGroup(messengerAPIToken ?? '');
    setState(() {});
    print("group length");
    print(groupList?.length);
  }

  List groupUserList = [];

  @override
  void initState() {
    super.initState();

    callgetChatPeople();

    pirntSocketChatToken();
    setState(() {});
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        isKeyboardVisible = true;
      }
    });
  }

  void dispose() {
    myFocusNode.dispose();

    super.dispose();
  }

  bool isKeyboardVisible = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    isKeyboardVisible = keyboardHeight > 0;
    setState(() {});
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
                        return groupList?.length != null
                            ? ListTile(
                                contentPadding: EdgeInsets.zero,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChattingDetailsScreen(
                                                manualUserId: '',
                                                userId: '',
                                                roomId: '',
                                                roomName: '',
                                                name: '',
                                                phoneNumber: '',
                                                avatar: '',
                                              )));
                                },
                                leading: Container(
                                    height: 45.05,
                                    width: 40,
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                    child: Image.network(
                                        "https://kjh.ksdr1.net/wp-content/uploads/sites/7/2017/08/nopicture_man.jpg"
                                        // groupList?[index]['avatar'],
                                        )),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          groupList?[index]['room'] ?? 'None',
                                          style: small14StyleW500.copyWith(
                                              height: 0),
                                        ),
                                        const Spacer(),
                                        Text(
                                          groupList?[index]['datetime'] ??
                                              'None',
                                          style: small12Stylew400,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : ChatFrontScreenShimmer(size: size);
                      })),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            //  isKeyboardVisible = true
            allPerson.clear();
            groupUserList.clear();
            allPerson =
                await socketMethod.getChatPeople(messengerAPIToken ?? '');
            setState(() {});
            final result = await showModalBottomSheet(
              useSafeArea: true,
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  child: _buildBottomSheet(context),
                );
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
      expand: false,
      builder: (context, scrollController) {
        return StatefulBuilder(builder: (context, setState) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                child: SingleChildScrollView(
                    primary: false,
                    controller: scrollController,
                    child: Column(
                      children: [
                        height20,
                        height10,
                        Stack(
                          children: [
                            ListView.separated(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: allPerson.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: groupUserList
                                              .contains(allPerson[index]['id'])
                                          ? Colors.green
                                          : Colors.grey,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    onTap: () {
                                      String personId = allPerson[index]
                                          ['id']; // Get the person ID

                                      if (groupUserList.contains(personId)) {
                                        groupUserList.remove(personId);
                                        setState(() {});
                                        ;
                                      } else {
                                        // If not selected, add the person to the group
                                        groupUserList.add(personId);
                                        setState(() {});
                                        ;
                                      }
                                    },
                                    leading: Container(
                                        height: 45.05,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle),
                                        child: Image.network(
                                            allPerson[index]['avatar'])),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              allPerson[index]['name'] ??
                                                  'None',
                                              style: small14StyleW500.copyWith(
                                                  height: 0),
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return height10;
                              },
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                Map body = {"title": null, "users": groupUserList};
                socketMethod.createGrop(messengerAPIToken ?? '', body);
                await callgetChatPeople();

                setState(() {});
                Navigator.pop(context);
              },
              child: Icon(Icons.add),
            ),
          );
        });
      },
    );
  }

  int count = 0;

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
