import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';

class ChatBubbl extends StatelessWidget {
  final bool isMe;
  final String message;
  const ChatBubbl({super.key, this.isMe = true, required this.message});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: isMe
              ? EdgeInsets.only(right: 10, bottom: 10)
              : EdgeInsets.only(left: 10, bottom: 10),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment:
                    isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  isMe
                      ? TextButton(
                          onPressed: () {
                            return print("three dots is pressed");
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("...",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Image.asset('assets/images/chatFont.png'),
                        ),
                  Flexible(
                    child: IntrinsicWidth(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(color: searchBarBorderColor),
                          color: const Color.fromARGB(255, 188, 204, 188),
                          borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(10),
                              topRight: const Radius.circular(10),
                              bottomLeft: Radius.circular(isMe ? 10 : 0),
                              bottomRight: Radius.circular(isMe ? 0 : 10)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: isMe
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                  softWrap: true,
                                  maxLines: 500,
                                  overflow: TextOverflow.ellipsis,
                                  message,
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  isMe
                      ? SizedBox()
                      : TextButton(
                          onPressed: () {
                            return print("three dots is pressed");
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("...",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                  )),
                              Text('.')
                            ],
                          ),
                        ),
                ],
              ),
              // Padding(
              //   padding: isMe ? EdgeInsets.zero : EdgeInsets.only(left: 80),
              //   child: Text(
              //     "3.00 PM",
              //     style: TextStyle(color: Colors.black, fontSize: 10),
              //   ),
              // ),
            ],
          ),
        ),
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
