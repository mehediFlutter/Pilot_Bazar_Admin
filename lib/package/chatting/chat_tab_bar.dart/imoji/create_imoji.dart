import 'package:flutter/material.dart';

class CreateEmojiAndOnTap extends StatelessWidget {
  const CreateEmojiAndOnTap({
    super.key,
    required this.emoji,
    required this.onTap,
  });

  final String emoji;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
          onTap: onTap,
          child: Text(
            "  ${emoji}  ",
            style: TextStyle(fontSize: 20),
          )),
    );
  }
}

class Emojis {
  String THUMBS_UP = '👍';
  String RED_HEART = '❤️';
  String FACE_WITH_TEARS_OF_JOY = '😂';
  String HUSHED_FACE = '😯';
  String FOLDED_HANDS = '🙏';
}
