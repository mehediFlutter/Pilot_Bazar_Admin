import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/DTO/contact_people.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_tab_bar.dart/inbox_chat_details.dart';
import 'package:pilot_bazar_admin/provider/socket_methode_provider.dart';
import 'package:pilot_bazar_admin/shimmer_effect/chat_front_screen_shimmer.dart';
import 'package:pilot_bazar_admin/socket_io/socket_manager.dart';
import 'package:pilot_bazar_admin/socket_io/socket_method.dart';
import 'package:pilot_bazar_admin/socket_io/tokens.dart';
import 'package:provider/provider.dart';
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
  TextEditingController groupNameController = TextEditingController();
  SharedPreferences? prefss;

  String? socketId;
  var socket = SocketManager().socket;
  var socketMethod = SocketMethod();
  FocusNode myFocusNode = FocusNode();

  List contacts = [];
  List contactNumber = [];
  Map<String, dynamic>? body;
  List<ContactPeopleDTO>? allPerson;
  bool isSelectForCreateGroup = false;
  bool isSelected = false;

  pirntSocketChatToken() async {
    prefss = await SharedPreferences.getInstance();
    String token = await prefss?.getString('authorizeChatToken') ?? '';

    String? authToken = await prefss?.getString('token');
  }

  List? groupList;
  // List? filteredGoupList;

  // void _filteredGroupList() {
  //   String query = searchController.text;
  //   setState(() {
  //     if (query.isEmpty) {
  //       filteredGoupList = groupList;
  //     } else {
  //       filteredGoupList = groupList
  //           ?.where((group) => group['room'].toLowerCase().contains(query))
  //           .toList();
  //     }
  //   });
  // }

  getGroupsPeople() async {
    groupList?.clear();
    groupList = await socketMethod.getGroup('groups');
    setState(() {});
  }

  List groupUserList = [];

  @override
  void initState() {
    super.initState();

    getGroupsPeople();

    pirntSocketChatToken();
    setState(() {});
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        isKeyboardVisible = true;
      }
    });
    // searchController.addListener(_filteredGroupList);
  }

  void dispose() {
    myFocusNode.dispose();

    super.dispose();
  }

  bool isKeyboardVisible = false;
  @override
  Widget build(BuildContext context) {
    // if (filteredGoupList == null) {
    //   filteredGoupList = groupList;
    // }
    setState(() {});
    Size size = MediaQuery.sizeOf(context);

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
                hintText: 'Search',
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
                                                image: '',
                                              )));
                                },
                                leading: Container(
                                    height: 45.05,
                                    width: 40,
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                    child: Image.network(
                                        groupList?[index]['image'])),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          groupList?[index]['room']['name'] ??
                                              'None',
                                          style: small14StyleW500.copyWith(
                                              height: 0),
                                        ),
                                        const Spacer(),
                                        Text(
                                          groupList?[index]['time']['format'] ??
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
            print("Elevated button is pressed");
            // allPerson?.clear();
            groupUserList.clear();

            setState(() {});

            final result = await showModalBottomSheet(
              context: context,
              useSafeArea: true,
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
    allPerson = Provider.of<SocketMethodeProvider>(context, listen: false)
        .getinboxChatListFromProvider;
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
                        SearchTextFild(
                          searchController: groupNameController,
                          hintText: "Group Name",
                          isSearch: false,
                        ),
                        height10,
                        Stack(
                          children: [
                            ListView.separated(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: allPerson?.length ?? 0,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: groupUserList.contains(
                                              allPerson?[index].user?.id ??
                                                  '123')
                                          ? Colors.green
                                          : Colors.grey,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    onTap: () {
                                      print(
                                          allPerson?[index].user?.id ?? '123');
                                      String personId =
                                          allPerson?[index].user?.id ??
                                              '123'; // Get the person ID

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
                                            allPerson?[index].user?.image ??
                                                '')),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              allPerson?[index].user?.name ??
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
                Map body = {
                  "group": true,
                  "title": groupNameController.text,
                  "users": groupUserList
                };
                await socketMethod.createGrop(messengerAPIToken ?? '', body);
                Navigator.pop(context);
                await getGroupsPeople();
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
