import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_tab_bar.dart/chat_bubble.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';
import 'package:pilot_bazar_admin/socket_io/socket_manager.dart';

class ChattingDetailsScreen extends StatefulWidget {

  const ChattingDetailsScreen({super.key});

  @override
  State<ChattingDetailsScreen> createState() => _ChattingDetailsScreenState();
}

class _ChattingDetailsScreenState extends State<ChattingDetailsScreen> {
  TextEditingController sendTextController = TextEditingController();
  FocusNode focusNode = FocusNode();
  var socket = SocketManager().socket;

  void sendMessage() {
    if (sendTextController.text.isNotEmpty) {
      String message = sendTextController.text;
      socket.emit('send_message', {'status': false, 'message': message});
      sendTextController.clear();
    }
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
              notification_image_path: 'assets/icons/message_notification.png',
              drawer_icon_path: 'assets/icons/beside_message.png',
              onTapFunction: () {},
              chatTap: () {
                print("notificaiton tap");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChattingDetailsScreen()));
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
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(chatList[index]
                      .message), // Fix: accessing the 'message' property
                );
              },
            ),
          ]),
          floatingActionButton: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  controller: sendTextController,
                  onSubmitted: (value) {
                    sendMessage(); // Send the message when the user submits
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  sendMessage();
                  if (sendTextController.text.isNotEmpty) {
                    chatList.add(
                      ChatBubbl.ChatBubble(
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
          )),
    );
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(border: OutlineInputBorder()),
            focusNode: focusNode,
            controller: sendTextController,
          ),
        ),
        IconButton(
          onPressed: () {
            if (sendTextController.text.isNotEmpty) {
              chatList.add(
                ChatBubbl.ChatBubble(
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
