import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_tab_bar.dart/chat_details.dart';
import 'package:pilot_bazar_admin/shimmer_effect/chat_front_screen_shimmer.dart';
import 'package:pilot_bazar_admin/socket_io/socket_manager.dart';
import 'package:pilot_bazar_admin/socket_io/socket_method.dart';
import 'package:pilot_bazar_admin/socket_io/tokens.dart';
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
  SharedPreferences? prefss;

  String? socketId;
  var socket = SocketManager().socket;
  var socketMethod = SocketMethod();

  List contacts = [];
  List contactNumber = [];
  Map<String, dynamic>? body;
  List filteredItems = [];

  pirntSocketChatToken() async {
    prefss = await SharedPreferences.getInstance();
    String token = await prefss?.getString('authorizeChatToken') ?? '';
    print("Auth Token from chat screen Local");
    print(token.toString());
    print("Auth Token from chat screen Variable");
    print(messengerAPIToken.toString());
    String? authToken = await prefss?.getString('token');
  }

  List? peopleList;

  callgetChatPeople() async {
    peopleList = await socketMethod.getChatPeople(messengerAPIToken ?? '');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    universalViewBool = true;
    universalCustomBool = true;
    print("Socket Id");
    print(socket.id);
    callgetChatPeople();
    pirntSocketChatToken();
    
    
  
  }

  void filterList() {
    setState(() {
      String query = searchController.text.toLowerCase();
      filteredItems = peopleList!.where((item) {
        return item.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            height10,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SearchTextFild(
                searchController: searchController,
              ),
            ),
            height10,
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: peopleList?.length ?? 15,
                  // itemCount: peopleList?.length,
                  itemBuilder: (context, index) {
                    return peopleList != null
                        ? ListTile(
                            contentPadding: EdgeInsets.zero,
                            onTap: () {
                              print(peopleList?[index]['avatar']);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChattingDetailsScreen(
                                            manualUserId:
                                                '01j9f3d86s4wgnnxjja828dez0',
                                            userId: peopleList?[index]['id'],
                                            roomId: peopleList?[index]['room']
                                                ['room_id'],
                                            roomName: peopleList?[index]['room']
                                                ['room_name'],
                                            name: peopleList?[index]['name'],
                                            phoneNumber: peopleList?[index]
                                                ['phone'],
                                            avatar: peopleList?[index]
                                                ['avatar'],
                                            isChatScreen: true,
                                          )));
                            },
                            leading: Container(
                                height: 45.05,
                                width: 40,
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle),
                                child: Image.network(
                                    peopleList?[index]['avatar'])),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      peopleList?[index]['name'] ?? 'None',
                                      style:
                                          small14StyleW500.copyWith(height: 0),
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
                          )
                        : ChatFrontScreenShimmer(size: size);
                    // :ChatFrontScreenShimmer(size: size,);
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
