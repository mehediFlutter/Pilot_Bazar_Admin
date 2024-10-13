import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_tab_bar.dart/chat_details.dart';
import 'package:pilot_bazar_admin/provider/socket_methode_provider.dart';
import 'package:pilot_bazar_admin/shimmer_effect/chat_front_screen_shimmer.dart';
import 'package:pilot_bazar_admin/socket_io/socket_manager.dart';
import 'package:pilot_bazar_admin/socket_io/socket_method.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../widget/search_text_fild.dart';
import '../../drawer/drawer_bool.dart';

class InboxChatScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  InboxChatScreen({
    super.key,
  });

  @override
  State<InboxChatScreen> createState() => _InboxChatScreenState();
}

class _InboxChatScreenState extends State<InboxChatScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController groupNameController = TextEditingController();
  SharedPreferences? prefss;

  String? socketId;
  var socket = SocketManager().socket;
  var socketMethod = SocketMethod();

  List contacts = [];
  List contactNumber = [];
  Map<String, dynamic>? body;

  pirntSocketChatToken() async {
    prefss = await SharedPreferences.getInstance();
    String token = await prefss?.getString('authorizeChatToken') ?? '';
    String? authToken = await prefss?.getString('token');
  }



  List? peopleList;
  List? filteredPeopleList;
  @override
  void initState() {
    universalViewBool = true;
    universalCustomBool = true;
    pirntSocketChatToken();

    setState(() {});
    searchController.addListener(_filterPeopleList);
  }

  void _filterPeopleList() async {
    String query = searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredPeopleList =
            peopleList; // Show full list if search query is empty
      } else {
        filteredPeopleList = peopleList
            ?.where((person) => person['user']['name']
                .toLowerCase()
                .contains(query)) // Search by name
            .toList();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    peopleList = Provider.of<SocketMethodeProvider>(context,listen: true)
        .getinboxChatListFromProvider;
    setState(() {});
    Size size = MediaQuery.sizeOf(context);

    if (filteredPeopleList == null) {
      filteredPeopleList = peopleList;
    }
    setState(() {});
   

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            height10,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SearchTextFild(
                searchController: searchController,
                isSearch: true,
                hintText: 'Search',
              ),
            ),
            height10,
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: (filteredPeopleList == null || filteredPeopleList!.isEmpty
                  // filteredPeopleList?[1]['user']?['id'] == null
                  )
                  ? Center(
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                        
                          return ChatFrontScreenShimmer(size: size);
                        },
                      ),
                    )
                  : ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: filteredPeopleList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChattingDetailsScreen(
                                          manualUserId:
                                              '01j9f3d86s4wgnnxjja828dez0',
                                          userId: filteredPeopleList?[index]
                                              ['user']['id'],
                                          roomId: filteredPeopleList?[index]
                                              ['room']['room_id'],
                                          roomName: filteredPeopleList?[index]
                                              ['room']['room_name'],
                                          name: filteredPeopleList?[index]
                                              ['user']['name'],
                                          image: filteredPeopleList?[index]
                                              ['user']['image'],
                                          isChatScreen: true,
                                        ))).then((result) {
                              if (result == true) {
                                setState(() {});
                              }
                            });
                          },
                          leading: Container(
                              height: 45.05,
                              width: 45,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Image.network(filteredPeopleList?[index]
                                          ['user']['image']),
                                      ((filteredPeopleList?.length == null) &&
                                              (filteredPeopleList?[index]
                                                  ?['user']?['online']))
                                          ? Positioned(
                                              height: 70,
                                              left: 32,
                                              child: Container(
                                                height: 12,
                                                width: 12,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.green,
                                                ),
                                              ))
                                          : SizedBox(),
                                    ],
                                  ),
                                ],
                              )),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          filteredPeopleList?[index]['user']
                                              ['name'],
                                          style: small16StyleW600),
                                      Text(
                                        filteredPeopleList?[index]['chat']
                                                ['content'] ??
                                            'conversation not started yet',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Text(
                                    "5.20 PM",
                                    style: small12Stylew400,
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    (filteredPeopleList?[index]?['user']
                                                ?['online'] ??
                                            false)
                                        ? "Active"
                                        : '',
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
                        // : ChatFrontScreenShimmer(size: size);
                      }),
            ))
          ],
        ),
      ),
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
