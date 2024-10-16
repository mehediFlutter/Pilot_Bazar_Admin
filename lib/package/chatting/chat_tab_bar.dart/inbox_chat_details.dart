import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:pilot_bazar_admin/DAO/send_chat_message.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_tab_bar.dart/chat_bubble.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';
import 'package:pilot_bazar_admin/screens/single_vehicle_screen.dart';
import 'package:pilot_bazar_admin/socket_io/socket_manager.dart';
import 'package:pilot_bazar_admin/socket_io/socket_method.dart';
import 'package:pilot_bazar_admin/socket_io/tokens.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';

class ChattingDetailsScreen extends StatefulWidget {
  final String userId;
  final String roomName;
  final String roomId;
  final String manualUserId;
  final String name;
  final String image;
  final bool isChatScreen;

  const ChattingDetailsScreen(
      {super.key,
      required this.userId,
      required this.roomName,
      required this.roomId,
      required this.manualUserId,
      required this.name,
      required this.image,
      this.isChatScreen = false});

  @override
  State<ChattingDetailsScreen> createState() => _ChattingDetailsScreenState();
}

class _ChattingDetailsScreenState extends State<ChattingDetailsScreen> {
  TextEditingController sendMessageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  FocusNode myFocusNode = FocusNode();
  // final SocketManager socketManager = SocketManager();

  var socket = SocketManager().socket;
  var socketMethod = SocketMethod();
  List getChats = [];

  String getCurrentDateTime() {
    DateTime now = DateTime.now();
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
  }

  getChatMethode() async {
    getChats = await socketMethod.getMessageMethod(
        messengerAPIToken ?? '', widget.roomId);
    setState(() {});
  }

  List chatList = [
    ChatBubbl.ChatBubble(
      isMe: false,
      message: "Hello ",
    ),
  ];
  void scrollDown() {
    {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
    }
  }

  var decodedSendMessageBody;

  Future<void> sendMessageMethod(
      String roomId, userId, messageFromTextFild) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-Encoding': 'application/gzip',
      'Authorization': 'Bearer $messengerAPIToken'
    };

    Map body = {
      "room_id": roomId,
      "user_id": userId,
      "bracket": "T",
      "content": messageFromTextFild
    };
    Response response = await post(
        Uri.parse("$chatBaseUrl-management/messages"),
        headers: headers,
        body: jsonEncode(body));

    decodedSendMessageBody = jsonDecode(response.body);
    setState(() {});
    print("Body");
    print(decodedSendMessageBody);
    getChats.add(decodedSendMessageBody);
  }

  sendMessage(String roomName, String roomId, String userId,
      String messageFromTextField) {
    print("Socket message");

    //{room: {id: 01ja8xxk0vfxjx6p4kqt88fdyq, name: StalwartHawk}, bracket: T, content: vaiy }
//{contact: {id: 01ja8xxk0vfxjx6p4kqt88fdyq, name: StalwartHawk}, bracket: T, content: vaiy }

    SendMessageDAO sendMessageDAO =
        SendMessageDAO.fromParam(roomId, roomName, "T", messageFromTextField);

    print("from DAO");
    print(sendMessageDAO.toObject());
     socket.emit('createChat', sendMessageDAO.toObject());
  }

  @override
  void initState() {
    getChatMethode();

    setState(() {});

    socket.on(
        'joined',
        (data) async => {
              // find out user current screen
              // if current == chat screen then http(online) do not call.
              //    if {safin auto} is online or offline status ebong current chat screen er user name
              //

              // [x] - if current == contact screen http(online) call hobe.
              // [x] - add button = image(phot and gallery),camera, video, document, audio
              // [x] - when add any kind of above things then open a bottom sheet to confirm send from user

              // and behind the seen when open bottom sheet then call the http upload api. to store attachment
              // delete or send

              print(data),
              if (socket.id == null)
                {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("You are offline"))),
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SingleVehicleScreen()),
                      (route) => false)
                }
            });
    socket.on('leaved', (data) async => {print(data)});

    socket.on('myself', (data) async {
      print(data);
    });

    socket.on('isSentChat', (data) async {
      print("is sent chat socket");
      print(data);

      await Future(() {
        if (data != null && data.isNotEmpty) {
          getChats.add(data);
        }
        ; // Add the data to getChats
      });

      sendMessageController.clear(); // Clear the input field

      setState(() {}); // Update the UI
    });

    socket.on('reloadChat', (data) async {
      print("reload chat");
      print(data);
      await Future(() {
        getChats.add(data); // Add the data to getChats
      });
      setState(() {});
    });

    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        //  cause a delay so that keyboard has time to show up
        Future.delayed(Duration(milliseconds: 500), () => scrollDown());
      }
    });
    Future.delayed(Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    myFocusNode.dispose();

    sendMessageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        // bottomNavigationBar: Row(
        //   children: [SizedBox(width: 10), Expanded(child: TextField())],
        // ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: CustomerProfileBar(
              profileImagePath: 'assets/images/small_profile.png',
              message_icon_path: 'assets/icons/message_notification.png',
              drawer_icon_path: 'assets/icons/beside_message.png',
              isChatAvater: widget.isChatScreen,
              chatAvater: widget.image,
              merchantName: widget.name,
              companyName: '',
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
          height10,
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              itemCount: getChats.length + 1,
              itemBuilder: (context, index) {
                if (index == getChats.length) {
                  return SizedBox(height: 30);
                }
                return ChatBubbl.ChatBubble(
                    message: getChats[index]['chat']['content'],
                    isMe: getChats[index]['side'] == 'R' ? true : false
                    // isMe: getChats[index]['side'] == 'R' ? true : false
                    );
                // Fix: accessing the 'message' property
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: TextField(
                    controller: sendMessageController,
                    focusNode: myFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Aa...',
                      hintStyle: TextStyle(color: Color(0xFF666666)),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: searchBarBorderColor),
                          borderRadius: BorderRadius.circular(30)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: searchBarBorderColor),
                          borderRadius: BorderRadius.circular(30)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: searchBarBorderColor),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (sendMessageController.text.isNotEmpty) {
                    sendMessage(
                      widget.roomName,
                      widget.roomId,
                      widget.userId,
                      sendMessageController.text,
                    );
                    sendMessageController.clear();
                  }

                  scrollDown(); // Ensure scrolling after message sending
                },
                icon: Image.asset('assets/icons/semd_message.png'),
              )
            ],
          ),
          height20,
        ]),
      ),
    );
  }

  // Widget _buildUserInput() {
  //   return Row(
  //     children: [
  //       Expanded(
  //           child: SearchTextFild(searchController: sendMessageController)),
  //       IconButton(
  //         onPressed: () {
  //           if (sendMessageController.text.isNotEmpty) {
  //             chatList.add(
  //               ChatBubbl(
  //                 isMe: true, // Assuming you're adding your own message
  //                 message: sendMessageController.text,
  //               ),
  //             );

  //             setState(() {});

  //             sendMessageController.clear();
  //           }
  //           Provider.of<SocketMethodeProvider>(context, listen: true)
  //               .getInbox(messengerAPIToken ?? '');
  //         },
  //         icon: Icon(Icons.send),
  //       )
  //     ],
  //   );
  // }

  chatImage(String imagePath) {
    return Container(
        height: 30.05,
        width: 30,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Image.asset(imagePath));
  }
}
