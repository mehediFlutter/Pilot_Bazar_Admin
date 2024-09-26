import 'package:flutter/material.dart';

class ExacklyChatLeading extends StatefulWidget {
  final String? detailsChatLeadingPath;
  const ExacklyChatLeading({super.key, this.detailsChatLeadingPath});

  @override
  State<ExacklyChatLeading> createState() => _ExacklyChatLeadingState();
}

class _ExacklyChatLeadingState extends State<ExacklyChatLeading> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        //  padding: EdgeInsets.only(left: 20),
        height: 27,
        width: 27,
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: Color(0xFF2D70D3)),
        child: SizedBox(
            height: 22,
            width: 22,
            child: Image.asset(widget.detailsChatLeadingPath ?? '')),
      ),
    );
  }
}
