import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_tab_bar.dart/imoji/create_imoji.dart';

class ChatBubbl extends StatefulWidget {
  final bool isMe;
  final String message;

  const ChatBubbl.ChatBubble(
      {super.key, this.isMe = true, required this.message});

  @override
  State<ChatBubbl> createState() => _ChatBubblState();
}

class _ChatBubblState extends State<ChatBubbl> {
  String? showEmoji;
  Emojis emojis = Emojis();
  bool _isPopupVisible = false;

  void _togglePopup() {
    setState(() {
      _isPopupVisible = !_isPopupVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: widget.isMe
              ? EdgeInsets.only(right: 10, bottom: 10)
              : EdgeInsets.only(left: 10, bottom: 10),
          child: Column(
            crossAxisAlignment:
                widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: widget.isMe
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  widget.isMe
                      ? Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: PopupMenuButton(
                            child: Container(
                              padding: EdgeInsets.all(2),
                              child: Column(
                                children: [
                                  Text("...",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  height20,
                                ],
                              ),
                            ),
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(child: Text("Copy")),
                                PopupMenuItem(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CreateEmojiAndOnTap(
                                              emoji: emojis.THUMBS_UP,
                                              onTap: () {
                                                showEmoji = emojis.THUMBS_UP;
                                                if (mounted) {
                                                  setState(() {});
                                                }
                                                Navigator.pop(context);
                                              }),
                                          CreateEmojiAndOnTap(
                                              emoji: emojis.RED_HEART,
                                              onTap: () {
                                                showEmoji = emojis.RED_HEART;
                                                if (mounted) {
                                                  setState(() {});
                                                }
                                                Navigator.pop(context);
                                              }),
                                          CreateEmojiAndOnTap(
                                              emoji:
                                                  emojis.FACE_WITH_TEARS_OF_JOY,
                                              onTap: () {
                                                showEmoji = emojis
                                                    .FACE_WITH_TEARS_OF_JOY;
                                                if (mounted) {
                                                  setState(() {});
                                                }
                                                Navigator.pop(context);
                                              }),
                                          CreateEmojiAndOnTap(
                                              emoji: emojis.HUSHED_FACE,
                                              onTap: () {
                                                showEmoji = emojis.HUSHED_FACE;
                                                if (mounted) {
                                                  setState(() {});
                                                }
                                                Navigator.pop(context);
                                              }),
                                          CreateEmojiAndOnTap(
                                              emoji: emojis.FOLDED_HANDS,
                                              onTap: () {
                                                showEmoji = emojis.FOLDED_HANDS;
                                                if (mounted) {
                                                  setState(() {});
                                                }
                                                Navigator.pop(context);
                                              }),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ];
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Image.asset('assets/images/chatFont.png'),
                        ),
                  Flexible(
                    child: IntrinsicWidth(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: searchBarBorderColor),
                              color: widget.isMe
                                  ? const Color.fromARGB(255, 114, 200, 114)
                                  : Colors.grey,
                              borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(10),
                                  topRight: const Radius.circular(10),
                                  bottomLeft:
                                      Radius.circular(widget.isMe ? 10 : 0),
                                  bottomRight:
                                      Radius.circular(widget.isMe ? 0 : 10)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: widget.isMe
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                      softWrap: true,
                                      maxLines: 500,
                                      overflow: TextOverflow.ellipsis,
                                      widget.message,
                                      style: TextStyle(color: Colors.black)),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                //    color: Colors.grey
                              ),
                              child: Text(showEmoji ?? ''),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  widget.isMe
                      ? SizedBox()
                      : TextButton(
                          onPressed: () {
                            _togglePopup();
                          },
                          child: Text("...",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                              )),
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

  createNotEmojiAndOnTap(String text, Function() onTap) {
    return Expanded(
      child: InkWell(
          onTap: onTap,
          child: Text(
            "  ${text}  ",
            style: TextStyle(fontSize: 15),
          )),
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
