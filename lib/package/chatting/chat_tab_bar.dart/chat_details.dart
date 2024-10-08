import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_tab_bar.dart/chat_bubble.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';
import 'package:pilot_bazar_admin/socket_io/socket_manager.dart';
import 'package:pilot_bazar_admin/socket_io/socket_method.dart';
import 'package:pilot_bazar_admin/socket_io/tokens.dart';
import 'package:pilot_bazar_admin/widget/search_text_fild.dart';

class ChattingDetailsScreen extends StatefulWidget {
  final String userId;
  final String roomName;
  final String roomId;
  final String manualUserId;
  final String name;
  final String phoneNumber;
  final String avatar;
  final bool isChatScreen;

  const ChattingDetailsScreen(
      {super.key,
      required this.userId,
      required this.roomName,
      required this.roomId,
      required this.manualUserId,
      required this.name,
      required this.phoneNumber,
      required this.avatar,
       this.isChatScreen=false});

  @override
  State<ChattingDetailsScreen> createState() => _ChattingDetailsScreenState();
}

class _ChattingDetailsScreenState extends State<ChattingDetailsScreen> {
  TextEditingController sendTextController = TextEditingController();
  FocusNode focusNode = FocusNode();
  var socket = SocketManager().socket;
  var socketMethod = SocketMethod();
  List getChats = [];
  void sendMessage() {
    if (sendTextController.text.isNotEmpty) {
      String message = sendTextController.text;
      socket.emit('send_message', {'status': false, 'message': message});
      sendTextController.clear();
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
    ChatBubbl(
      isMe: false,
      message: "Hello ",
    ),
    ChatBubbl(
      isMe: false,
      message: "Hello again ",
    ),
    ChatBubbl(
      isMe: false,
      message: "Hello again ",
    ),
    ChatBubbl(
      isMe: false,
      message: "Hello again ",
    ),
  ];

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(Duration(milliseconds: 500), () => scrollDown());
      }
    });
    socket.on('me', (data) {
      print('Received GoldenDuck event: $data');
    });

    getChatMethode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    sendTextController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  ScrollController scrollController = ScrollController();
  void scrollDown() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Row(
            children: [SizedBox(width: 10), Expanded(child: TextField())],
          ),
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomerProfileBar(
              profileImagePath: 'assets/images/small_profile.png',
              message_icon_path: 'assets/icons/message_notification.png',
              drawer_icon_path: 'assets/icons/beside_message.png',
              isChatAvater: true,
              chatAvater: widget.avatar,
              onTapFunction: () {},
              chatTap: () {
                // print("notificaiton tap");
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => ChattingDetailsScreen()));
              },
            ),
            height10,
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Spacer(),
                Icon(
                  Icons.phone_callback,
                  color: Colors.blue,
                  size: 20,
                ),
                width10,
                Icon(
                  Icons.video_call,
                  color: Colors.blue,
                  size: 20,
                ),
              ],
            ),
            SizedBox(height: 30),
            ListView.builder(
              controller: scrollController,
              //   primary: false,
              shrinkWrap: true,
              itemCount: getChats.length,
              itemBuilder: (context, index) {
                return ChatBubbl(
                    message: getChats[index]
                        ['content']); // Fix: accessing the 'message' property
              },
            ),
          ]),
          floatingActionButton: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SearchTextFild(searchController: sendTextController),
                ),
              ),
              IconButton(
                onPressed: () {
                  socketMethod.sendMessageMethod(
                    messengerAPIToken ?? '',
                    widget.roomId,
                    widget.manualUserId,
                    widget.userId,
                    sendTextController.text,
                  );

                  // sendMessage();
                  if (sendTextController.text.isNotEmpty) {
                    getChats.add({
                      "id": widget.roomId,
                      "userID": widget.userId,
                      "bracket": 'T',
                      "content": sendTextController.text,
                      "isSending": true,
                      "component": "text",
                      "datetime": getCurrentDateTime
                    });

                    setState(() {});

                    sendTextController.clear();
                  }
                },
                icon: Icon(Icons.send),
              )
            ],
          )),
    );
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(child: SearchTextFild(searchController: sendTextController)),
        IconButton(
          onPressed: () {
            if (sendTextController.text.isNotEmpty) {
              chatList.add(
                ChatBubbl(
                  isMe: true, // Assuming you're adding your own message
                  message: sendTextController.text,
                ),
              );

              setState(() {});

              sendTextController.clear();
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
