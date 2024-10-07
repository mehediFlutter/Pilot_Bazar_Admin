import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_details.dart';
import 'package:pilot_bazar_admin/re_usable_widget/re_usable_mother_widget.dart';
import 'package:pilot_bazar_admin/socket_io/socket_manager.dart';
import 'package:pilot_bazar_admin/socket_io/socket_method.dart';
import 'package:pilot_bazar_admin/socket_io/tokens.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widget/search_text_fild.dart';

class InboxChatScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  InboxChatScreen({
    super.key,
  });

  @override
  State<InboxChatScreen> createState() => _InboxChatScreenState();
}

class _InboxChatScreenState extends State<InboxChatScreen> {
  TextEditingController searchController = TextEditingController();
  SharedPreferences? prefss;

  String? socketId;
  var socket = SocketManager().socket;
  var socketMethod = SocketMethod();

  List contacts = [];
  List contactNumber = [];
  Map<String, dynamic>? body;

  Future<void> _fetchContacts() async {
    // Request permission to read contacts
    var status = await Permission.contacts.request();

    if (status.isGranted) {
      // Fetch all contacts
      contacts = await FlutterContacts.getContacts(withProperties: true);
      setState(() {});
      // setState(() {
      //   contacts = contacts; // Update the contacts list
      // });

      contacts.forEach((contact) {
        if (contact.phones.isNotEmpty) {
          contactNumber
              .add(contact.phones[0].number); // Add the first phone number
          print(contactNumber);
        }
      });

      for (var item in contactNumber) {
        print(item);
      }
      body = {"is_group": false, "contacts": contactNumber};
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: const Text('Contacts permission denied')),
      );
    }
  }

  pirntSocketChatToken() async {
    prefss = await SharedPreferences.getInstance();
    String token = await prefss?.getString('authorizeChatToken') ?? '';
    print("Auth Token from chat screen Local");
    print(token.toString());
    print("Auth Token from chat screen Variable");
    print(authorizeChatTokenFromOutSideVariable.toString());
    String? authToken = await prefss?.getString('token');
  }

  List? peopleList;

  callgetChatPeople() async {
    peopleList = await socketMethod
        .getChatPeople(authorizeChatTokenFromOutSideVariable ?? '');
    setState(() {});
    print("chat fromt screenddd");
    print(peopleList.toString());
  }

  @override
  void initState() {
    print("Socket Id");
    print(socket.id);
    print(authorizeChatTokenFromOutSideVariable.toString());
    callgetChatPeople();

    print("Token");
    print(authorizeChatTokenFromOutSideVariable);

    pirntSocketChatToken();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ReUsableMotherWidget(
      children: [
        height10,
        SearchTextFild(
          searchController: searchController,
          onSubmit: (value) async {
            print("onSubmitted: $value");
          },
        ),
        height10,
        Expanded(
            child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: peopleList?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      print(peopleList?[index]['avatar']);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChattingDetailsScreen()));
                    },
                    leading: Container(
                        height: 45.05,
                        width: 40,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: Image.network(peopleList?[index]['avatar'])),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              peopleList?[index]['name'] ?? 'None',
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
                              peopleList?[index]['phone'] ?? 'None',
                              style: small10Style.copyWith(height: 0),
                            ),
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

  inboxOrGroup(String text, Function() onTap) {
    return Container(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          width: 118,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(30)),
          child: Center(
            child: Text(
              text,
              style: small14StyleW500.copyWith(color: Colors.blue),
            ),
          ),
        ),
      ),
    );
  }
}
