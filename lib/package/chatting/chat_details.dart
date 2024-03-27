import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';
import 'package:pilot_bazar_admin/re_usable_widget/re_usable_mother_widget.dart';

class ChattingDetailsScreen extends StatefulWidget {
  final ValueNotifier<ThemeMode> notifier;

  ChattingDetailsScreen({super.key, required this.notifier});

  @override
  State<ChattingDetailsScreen> createState() => _ChattingDetailsScreenState();
}

class _ChattingDetailsScreenState extends State<ChattingDetailsScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ReUsableMotherWidget(notifier: widget.notifier, children: [
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
                  builder: (context) => ChattingDetailsScreen(
                        notifier: widget.notifier,
                      )));
        },
      ),
      height10,
      Row(
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
      message(size,text:'I an looking for car cur I an looking for car cu', 'assets/images/chatFont.png', false, ),
      message(size,text:"hello sir how can i helop you hello sir how can i helop you ",
          'assets/images/chatFont.png', true, ),
      message(size,text:"hello sir ", 'assets/images/chatFont.png', false, ),
      message(size,text: "I am sendint you some of photos my car", 'assets/images/chatFont.png', true, ),
      message(size,text:"I am sendint you some of photos my car", 'assets/images/chatFont.png', true,isImage: true ),
      
     
    ]);
  }

  Widget message(Size size,  imagePath, bool isMe,{bool? isImage=false, String? text}) {
    return Padding(
                 padding:  EdgeInsets.only(right:isMe? 0:size.width/6,bottom: 25,left: isMe?size.width/6:0 ),

      child: Row(
     mainAxisAlignment: MainAxisAlignment.start,
        children: [
          isMe ? SizedBox() : chatImage(imagePath),
          isMe?SizedBox():SizedBox(width: 15,),
          isMe
              ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                    onTap: () {
                      print("Icon Print");
                    },
                    child: Icon(Icons.more_horiz,size: 15,),
                  ),
              )
              : SizedBox(),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(isMe?10:0),
                    bottomRight: Radius.circular(isMe?0:10)),
                border: Border.all(
                  color: searchBarBorderColor,
                ),
              ),
              child: Text(
                text??'',
              ),
            ),
          ),
          isMe
              ? SizedBox()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                    onTap: () {
                      print("Icon Print");
                    },
                    child: Icon(Icons.more_horiz,size: 15,),
                  ),
              )
        ],
      ),
    );
  }

  chatImage(String imagePath) {
    return Container(
        height: 30.05,
        width: 30,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Image.asset(imagePath));
  }
}
