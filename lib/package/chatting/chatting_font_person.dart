import 'package:flutter/material.dart';

class Chatting_profile_with_green_tolu extends StatefulWidget {
  final bool isActive;
  const Chatting_profile_with_green_tolu({
    super.key, this.isActive=true,
  });

  @override
  State<Chatting_profile_with_green_tolu> createState() => _Chatting_profile_with_green_toluState();
}

class _Chatting_profile_with_green_toluState extends State<Chatting_profile_with_green_tolu> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
       Container(
            height: 45.05,
            width: 40,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Image.asset('assets/images/chatFont.png')),
     
             widget.isActive? Container(
              margin: EdgeInsets.only(left: 30,top: 26),
          height: 11,
          width: 11,
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black,),
          child:  Image.asset('assets/icons/green_tolu.png'),
         
        ):SizedBox(),
       
      ],
    );
  }
}
