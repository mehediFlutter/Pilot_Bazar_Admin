import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
class SendMessageTextFild extends StatelessWidget {
  const SendMessageTextFild({
    super.key,
    required this.sendMessageController,
    required this.myFocusNode,
  });

  final TextEditingController sendMessageController;
  final FocusNode myFocusNode;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}
