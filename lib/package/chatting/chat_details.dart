import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_methode_class.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';
import 'package:pilot_bazar_admin/package/customer_requirement_store/input_fild.dart';

class ChattingDetailsScreen extends StatefulWidget {
  const ChattingDetailsScreen({super.key});

  @override
  State<ChattingDetailsScreen> createState() => _ChattingDetailsScreenState();
}

class _ChattingDetailsScreenState extends State<ChattingDetailsScreen> {
  TextEditingController sendTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Row(
          children: [
            SizedBox(width: size.width / 15),
            Container(
              height: 20,
              width: 20,
              decoration: const BoxDecoration(
                  color: Colors.blue, shape: BoxShape.circle),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 15,
              ),
            ),

            Expanded(
                child: CustomerRequiredTextFild(
              textFildController: sendTextController,
            )),
            //  Flexible(
            //    child: Container(
            //          width: double.infinity,
            //          height: 60,
            //          decoration: BoxDecoration(
            //     color: Colors.green,
            //          ),
            //          child: Align(
            //     alignment: Alignment.bottomCenter,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         IconButton(
            //           icon: Icon(Icons.add),
            //           onPressed: () {
            //           },
            //           color: Colors.green,
            //         ),
            //       ],
            //     ),
            //          ),
            //        ),
            //  ),
          ],
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomerProfileBar(
              profileImagePath: 'assets/images/small_profile.png',
              message_icon_path: 'assets/icons/message_notification.png',
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
            SizedBox(
              height: size.height / 30,
            ),
            SizedBox(height: size.height / 30),
            ChatMethodeClass(
              isMe: false,
              message:
                  "Hello do you have premio car if have  if have then i want iHello do you have premio car if have then i want i",
            ),
            ChatMethodeClass(
              message: "Yes Sir",
            ),

            // message(
            //   size,
            //   text: 'I an looking for car cur I an looking for car cu',
            //   'assets/images/chatFont.png',
            //   false,
            // ),
            // message(
            //   size,
            //   text:
            //       "hello sir how can i helop you hello sir how can i helop you ",
            //   'assets/images/chatFont.png',
            //   true,
            // ),
            // message(
            //   size,
            //   text: "hello sir ",
            //   'assets/images/chatFont.png',
            //   false,
            // ),
            // message(
            //   size,
            //   text: "I am sendint you some of photos my car",
            //   'assets/images/chatFont.png',
            //   true,
            // ),
            // message(
            //   size,
            //   text: "I am photos my car",
            //   'assets/images/chatFont.png',
            //   true,
            // ),
            // message(
            //     size,
            //     text: "I am sendint you some of photos my car",
            //     'assets/images/chatFont.png',
            //     true,
            //     isImage: true,
            //     chatImagePath: 'assets/images/chatting_image_pass.png'),
            // message(
            //     size,
            //     text: "I am sendint you some of photos my car",
            //     'assets/images/chatFont.png',
            //     false,
            //     isImage: true,
            //     chatImagePath: 'assets/images/chatting_image_pass.png'),
          ]),
        ),
      ),
    );
  }

  // Widget message(Size size, imagePath, bool isMe,
  //     {bool isImage = false, String? text, chatImagePath}) {
  //   return Padding(
  //     padding: EdgeInsets.only(
  //         right: isMe ? 0 : size.width / 6,
  //         bottom: 25,
  //         left: isMe ? size.width / 6 : 0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         isMe ? const SizedBox() : chatImage(imagePath),
  //         isMe
  //             ? const SizedBox()
  //             : const SizedBox(
  //                 width: 15,
  //               ),
  //         isMe
  //             ? Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 10),
  //                 child: InkWell(
  //                   onTap: () {
  //                     print("Icon Print");
  //                   },
  //                   child: const Icon(
  //                     Icons.more_horiz,
  //                     size: 15,
  //                   ),
  //                 ),
  //               )
  //             : const SizedBox(),
  //         Flexible(
  //           child: Align(
  //             alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
  //             child: Container(
  //               padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.only(
  //                     topLeft: const Radius.circular(10),
  //                     topRight: const Radius.circular(10),
  //                     bottomLeft: Radius.circular(isMe ? 10 : 0),
  //                     bottomRight: Radius.circular(isMe ? 0 : 10)),
  //                 border:
  //                     isImage ? null : Border.all(color: searchBarBorderColor),
  //               ),
  //               child: isImage
  //                   ? Align(
  //                       alignment: Alignment.centerRight,
  //                       child: Image.asset(chatImagePath))
  //                   : Text(
  //                       text ?? '',
  //                       style: TextStyle(color: Colors.black),
  //                     ),
  //             ),
  //           ),
  //         ),
  //         isMe
  //             ? const SizedBox()
  //             : Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 10),
  //                 child: InkWell(
  //                   onTap: () {
  //                     print("Icon Print");
  //                   },
  //                   child: const Icon(
  //                     Icons.more_horiz,
  //                     size: 15,
  //                   ),
  //                 ),
  //               )
  //       ],
  //     ),
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
