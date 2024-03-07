import 'package:flutter/material.dart';

class ChattingDetailsLeading extends StatefulWidget {
  final bool isActive;
  final String? detailsChatLeadingPath;
  const ChattingDetailsLeading({
    super.key, this.isActive=true,  this.detailsChatLeadingPath,
  });

  @override
  State<ChattingDetailsLeading> createState() => _ChattingDetailsLeadingState();
}

class _ChattingDetailsLeadingState extends State<ChattingDetailsLeading> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
       Container(
        height: 47,
        width: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle
          ,color: Color(0xFF2D70D3)),
         child: Container(
              height: 45.05,
              width: 40,
             
              child: Image.asset(widget.detailsChatLeadingPath??'')),
       ),
     
             widget.isActive? Container(
              margin: EdgeInsets.only(left: 32,top: 26),
          height: 11,
          width: 11,
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black,),
          child:  Image.asset('assets/icons/green_tolu.png'),
         
        ):SizedBox(),
       
      ],
    );
  }
}