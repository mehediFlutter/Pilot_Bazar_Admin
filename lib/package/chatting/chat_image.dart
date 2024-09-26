import 'package:flutter/material.dart';

class Chatting_profile_with_green_tolu extends StatefulWidget {
  final bool isActive;
  const Chatting_profile_with_green_tolu({
    super.key,
    this.isActive = true,
  });

  @override
  State<Chatting_profile_with_green_tolu> createState() =>
      _Chatting_profile_with_green_toluState();
}

class _Chatting_profile_with_green_toluState
    extends State<Chatting_profile_with_green_tolu> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45.05,
        width: 40,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Image.asset('assets/images/chatFont.png'));
  }
}
