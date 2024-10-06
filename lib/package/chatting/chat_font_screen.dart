import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_details.dart';
import 'package:pilot_bazar_admin/package/chatting/chatting_font_person.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';
import 'package:pilot_bazar_admin/re_usable_widget/re_usable_mother_widget.dart';
import '../drawer/drawer_bool.dart';

class ChatFontScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  ChatFontScreen({
    super.key,
  });

  @override
  State<ChatFontScreen> createState() => _ChatFontScreenState();
}

class _ChatFontScreenState extends State<ChatFontScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    universalViewBool = true;
    universalCustomBool = true;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ReUsableMotherWidget(
      children: [
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
                    builder: (context) => ChattingDetailsScreen()));
          },
        ),
        height5,
        height5,
        Container(
          height: 40,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadious20,
          ),
          child: TextField(
            cursorColor: Colors.black,
            cursorWidth: 1.2,
            controller: searchController,
            // onChanged: _filterList,
            style: Theme.of(context).textTheme.bodySmall,
            cursorHeight: 15,
            decoration: InputDecoration(
                enabledBorder: searchBarBorder,
                focusedBorder: searchBarBorder,
                contentPadding: const EdgeInsets.only(
                  top: 8,
                ),
                hintText: "Search",
                hintStyle: Theme.of(context).textTheme.bodySmall,
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 15,
                  ),
                )),
          ),
        ),
        height10,
        Container(
          height: 40,
          width: 118,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(30)),
          child: Center(
            child: Text(
              "Inbox",
              style: small14StyleW500.copyWith(color: Colors.blue),
            ),
          ),
        ),
        height10,
        Expanded(
            child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChattingDetailsScreen()));
                    },
                    leading: const Chatting_profile_with_green_tolu(),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Shah Alam',
                              style: small14StyleW500.copyWith(height: 0),
                            ),
                            const Spacer(),
                            const Text(
                              "5.20 PM",
                              style: small12Stylew400,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "You: ",
                              style: small10Style.copyWith(height: 0),
                            ),
                            Container(
                                padding: EdgeInsets.zero,
                                width: 65,
                                child: Text(
                                  "Hello There is Any Car",
                                  style: small12Stylew400.copyWith(height: 0),
                                  overflow: TextOverflow.ellipsis,
                                )),
                            const Spacer(),
                            Image.asset(
                              'assets/icons/seenMessage.png',
                              color: Colors.blue,
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }))
      ],
    );
  }
}
