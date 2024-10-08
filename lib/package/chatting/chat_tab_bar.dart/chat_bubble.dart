import 'package:flutter/material.dart';

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
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: TextButton(
                            onPressed: () {
                              return print("three dots is pressed");
                            },
                            child: Text("...",
                                style: TextStyle(color: Colors.black)),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Image.asset('assets/images/chatFont.png'),
                        ),
                  Flexible(
                    child: IntrinsicWidth(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
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
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: TextButton(
                            onPressed: () {
                              return print("three dots is pressed");
                            },
                            child: Text("...",
                                style: TextStyle(color: Colors.black)),
                          ),
                        ),
                ],
              ),
              Padding(
                padding: isMe ? EdgeInsets.zero : EdgeInsets.only(left: 80),
                child: Text(
                  "3.00 PM",
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
              ),
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
