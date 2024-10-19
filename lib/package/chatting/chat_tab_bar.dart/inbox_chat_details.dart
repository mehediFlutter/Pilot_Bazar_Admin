import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pilot_bazar_admin/DAO/send_chat_message.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_tab_bar.dart/chat_bubble.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_tab_bar.dart/send_message_text_fild.dart';
import 'package:pilot_bazar_admin/package/chatting/select_send_documents/documents_and_icon_image_pick.dart';
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

  XFile? selectedImage;

  void handleImageSelected(XFile? image) {
    setState(() {
      selectedImage = image;
    });
  }

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
      var message = data;
      print("reload chat");

      message['side'] = 'L';
      print("From reload chat data");
      print(data);
      print("From reload chat message");
      print(message);

      await Future(() {
        getChats.add(message); // Add the data to getChats
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
         
             drawer_icon_path: 'assets/icons/beside_message.png',
              isChatAvater: widget.isChatScreen,
              chatAvater: widget.image,
              merchantName: widget.name,
              companyName: '',
             
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
                    //    isMe: getChats[index]['side'] == 'R' ? true : false
                    isMe: getChats[index]['side'] == 'R' ? true : false);
                // Fix: accessing the 'message' property
              },
            ),
          ),
          Column(
            children: [
             
              Row(
                children: [
                  DocumentsAddIcon(onImageSelected: handleImageSelected),
                  SendMessageTextFild(
                      sendMessageController: sendMessageController,
                      myFocusNode: myFocusNode),
                       if (selectedImage != null) ...[
                const SizedBox(height: 20),
                Image.file(File(selectedImage!.path),
                    width: 20, height: 20),
              ],
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
                    icon: Image.asset('$iconsPath/semd_message.png'),
                  )
                ],
              ),
            ],
          ),
          height20,
        ]),
      ),
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
