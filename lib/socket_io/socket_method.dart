import 'dart:convert';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:pilot_bazar_admin/socket_io/socket_manager.dart';
import 'package:pilot_bazar_admin/socket_io/tokens.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocketMethod {
  String? authorizeChatToken;
  Map? syncBodyContactNumbers;
  late SharedPreferences prefss;

  Future authorizeChat() async {
    prefss = await SharedPreferences.getInstance();

    final url = '$chatBaseUrl/api/v1/vendor-management/authorize';
    final headers = {
      "Accept": "application/json",
      'Content-Type': 'application/json',
      "Accept-Encoding": "application/gzip"
    };
    Map<String, dynamic> body = {
      "userid": "01j9f3d86s4wgnnxjja828dez0",
      "socket": "${SocketManager().socket.id}",
      "issued": "F"
    };

    Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final decodedBody = jsonDecode(response.body);
      authorizeChatToken = await decodedBody['token']; // Correct 'tokekn' typo

      authorizeChatTokenFromOutSideVariable = decodedBody['token'];

      print(" From Auth chat ");
      print("Authorize Token From AuthorizeChat Methode $authorizeChatToken");
    } else {
      print('Error: ${response.statusCode}');
    }
    await prefss.setString("authorizeChatToken", authorizeChatToken.toString());
    print("saving token $authorizeChatToken");
  }

  List contactNumber = [];
  Future<void> fetchContacts() async {
    var status = await Permission.contacts.request();

    if (status.isGranted) {
      // Fetch all contacts
      List contacts = await FlutterContacts.getContacts(withProperties: true);

      contacts.forEach((contact) {
        if (contact.phones.isNotEmpty) {
          contactNumber
              .add(contact.phones[0].number); // Add the first phone number
        }
      });

      print(contactNumber);
    }
  }

  Future<void> postPhoneNumber() async {
    Map<String, dynamic> body = {
      "is_group": false,
      "contacts": contactNumber, // Use your contact list here
    };
    Response response = await http.post(
      Uri.parse(
        'https://messenger.pilotbazar.xyz/api/v1/vendor-management/contacts',
      ),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Accept-Encoding": "application/gzip",
        "Authorization": 'Bearer $authorizeChatToken'
      },
      body: jsonEncode(body),
    );

    print(response.body);
    print("Post PHone number chat token is ");
    print(authorizeChatToken);
  }

  List getChatPeopleList = [];
  List getGroupChatList = [];
  Map<String, dynamic>? decodedBody;
  Map<String, dynamic>? decodeGroupChatdBody;
  List getChatPeopleListxyz = [];

  Future<List> getChatPeople(String token) async {
    print("Auth token from get chat people $token");
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-Encoding': 'application/gzip',
      'Authorization': 'Bearer $token'
    };
    Response response = await http.get(
        Uri.parse(
            "https://messenger.pilotbazar.xyz/api/v1/vendor-management/contacts"),
        headers: headers);

    print("Get Chat People Methode");
    print("status code is");
    print(response.statusCode);

    decodedBody = jsonDecode(response.body);

    for (var person in decodedBody?['people']) {
      var contact = await {
        "name": person["name"],
        "phone": person["phone"],
        "avatar": person["avatar"],
        "id": person["id"],
      };
      getChatPeopleList.add(contact);
    }

    return getChatPeopleList;
  }

  Future<List> getGroupChat(String token) async {
    print("Auth token from get chat people $token");
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-Encoding': 'application/gzip',
      'Authorization': 'Bearer $token'
    };
    Response response = await http.get(
        Uri.parse(
            "https://messenger.pilotbazar.xyz/api/v1/vendor-management/contacts"),
        headers: headers);

    print("Get Chat People Methode");
    print("status code is");
    print(response.statusCode);

    decodeGroupChatdBody = jsonDecode(response.body);
    for (var person in decodeGroupChatdBody?['groups']) {
      var contact = await {
        "id": person["id"],
        "room": person["room"],
        "datetime": person["datetime"],
        "avatar": person["avatar"],
      };
      getGroupChatList.add(contact);
    }

    return getGroupChatList;
  }
  Future<List> createGrop(String token, Map body) async {
    print("Auth token from create Group $token");
    print("Body $body");
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-Encoding': 'application/gzip',
      'Authorization': 'Bearer $token'
    };
    Response response = await http.post(
        Uri.parse(
            "https://messenger.pilotbazar.xyz/api/v1/vendor-management/contacts/group"),
        headers: headers,
        body: jsonEncode(body)
        );

    print("create Group");
    print("status code is");
    print(response.statusCode);

    decodeGroupChatdBody = jsonDecode(response.body);


    return getGroupChatList;
  }

  List get chatList => getChatPeopleList;
  List get chatGroup => getGroupChatList;
}
