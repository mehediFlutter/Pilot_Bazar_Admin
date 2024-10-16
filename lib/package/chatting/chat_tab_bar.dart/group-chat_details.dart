import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_tab_bar.dart/chat_bubble.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';
import 'package:pilot_bazar_admin/socket_io/socket_manager.dart';
import 'package:pilot_bazar_admin/socket_io/socket_method.dart';
import 'package:pilot_bazar_admin/socket_io/tokens.dart';
import 'package:pilot_bazar_admin/widget/search_text_fild.dart';

class GroupChattingDetailsScreen extends StatefulWidget {
  final String userId;
  final String roomName;
  final String roomId;
  final String manualUserId;
  final String name;
  final String phoneNumber;
  final String avatar;
  final bool isChatScreen;

  const GroupChattingDetailsScreen(
      {super.key,
      required this.userId,
      required this.roomName,
      required this.roomId,
      required this.manualUserId,
      required this.name,
      required this.phoneNumber,
      required this.avatar,
      this.isChatScreen = false});

  @override
  State<GroupChattingDetailsScreen> createState() =>
      _GroupChattingDetailsScreenState();
}

class _GroupChattingDetailsScreenState
    extends State<GroupChattingDetailsScreen> {
  TextEditingController sendMessageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  FocusNode myFocusNode = FocusNode();
  // final SocketManager socketManager = SocketManager();

  var socket = SocketManager().socket;
  var socketMethod = SocketMethod();
  List getChats = [];
  void sendMessage() {
    if (sendMessageController.text.isNotEmpty) {
      String message = sendMessageController.text;
      socket.emit('send_message', {'status': false, 'message': message});
      sendMessageController.clear();
    }
  }

  String getCurrentDateTime() {
    DateTime now = DateTime.now();
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
  }

  getChatMethode() async {
    getChats = await socketMethod.getMessageMethod(
        messengerAPIToken ?? '', widget.roomId);
    setState(() {});
    print(getChats.toString());
  }

  List chatList = [
    ChatBubbl.ChatBubble(
      isMe: false,
      message: "Hello ",
    ),
    ChatBubbl.ChatBubble(
      isMe: false,
      message: "Hello again ",
    ),
    ChatBubbl.ChatBubble(
      isMe: false,
      message: "Hello again ",
    ),
    ChatBubbl.ChatBubble(
      isMe: false,
      message: "Hello again ",
    ),
  ];
  void scrollDown() {
    {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
    }
  }

  // void _sendMessage() {
  //   String message = sendMessageController.text;
  //   if (message.isNotEmpty) {
  //     SocketManager()
  //         .chatEventHandler
  //         .sendMessage(message, widget.roomName, widget.roomId);
  //     sendMessageController.clear(); // Clear the input after sending
  //   }

  //   sendMessageController.clear(); // Clear the input after sending
  // }

  @override
  void initState() {
    getChatMethode();

    setState(() {});
    // socket.on('loadEvent', (data) {
    //   print(data);
    //   final res = jsonDecode(data);
    //   print(res['uuid']);
    //   getChats = socketMethod.getMessageMethod(
    //     messengerAPIToken ?? "",
    //     res['uuid'],
    //   );
    // });

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
              chatAvater: widget.avatar,
              merchantName: widget.name,
              companyName: widget.phoneNumber,
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
          Text(
            widget.name,
            style: TextStyle(fontSize: 30),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              itemCount: getChats.length + 1,
              itemBuilder: (context, index) {
                if (index == getChats.length) {
                  return SizedBox(height: 30);
                }
                return ChatBubbl.ChatBubble(message: getChats[index]['content']);
              },
            ),
          ),
          // SendMessageTextFild(
          //   sendMessageController: sendMessageController,
          //   myFocusNode: myFocusNode,
          //   sendMessageButton: IconButton(
          //     onPressed: () {
          //       socketMethod.sendMessageMethod(
          //         messengerAPIToken ?? '',
          //         widget.roomId,
          //         widget.manualUserId,
          //         widget.userId,
          //         sendMessageController.text,
          //       );

          //       // sendMessage();
          //       if (sendMessageController.text.isNotEmpty) {
          //         getChats.add({
          //           "id": widget.roomId,
          //           "userID": widget.userId,
          //           "bracket": 'T',
          //           "content": sendMessageController.text,
          //           "isSending": true,
          //           "component": "text",
          //           "datetime": getCurrentDateTime
          //         });

          //         setState(() {});

          //         sendMessageController.clear();
          //       }
          //       scrollDown();
          //     },
          //     icon: Image.asset('assets/icons/semd_message.png'),
          //   ),
          // ),
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
                  // socketMethod.sendMessageMethod(
                  //   messengerAPIToken ?? '',
                  //   widget.roomId,
                  //   widget.manualUserId,
                  //   widget.userId,
                  //   sendMessageController.text,
                  // );

                  // sendMessage();
                  if (sendMessageController.text.isNotEmpty) {
                    getChats.add({
                      "id": widget.roomId,
                      "userID": widget.userId,
                      "bracket": 'T',
                      "content": sendMessageController.text,
                      "isSending": true,
                      "component": "text",
                      "datetime": getCurrentDateTime
                    });

                    setState(() {});

                  //  _sendMessage();

                    sendMessageController.clear();
                  }
                  scrollDown();
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

  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
            child: SearchTextFild(searchController: sendMessageController)),
        IconButton(
          onPressed: () {
            if (sendMessageController.text.isNotEmpty) {
              chatList.add(
                ChatBubbl.ChatBubble(
                  isMe: true, // Assuming you're adding your own message
                  message: sendMessageController.text,
                ),
              );

              setState(() {});

              sendMessageController.clear();
            }
          },
          icon: Icon(Icons.send),
        )
      ],
    );
  }

  chatImage(String imagePath) {
    return Container(
        height: 30.05,
        width: 30,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Image.asset(imagePath));
  }
}
