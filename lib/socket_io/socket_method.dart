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

    final url = '$chatBaseUrl-management/authorize';
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

      messengerAPIToken = decodedBody['token'];

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
        '$chatBaseUrl-management/contacts',
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
  List getChats = [];
  List decodedGetChatBody = [];
  Map<String, dynamic>? decodedBody;
  Map<String, dynamic>? decodeGroupChatdBody;
  List getChatPeopleListxyz = [];
  Map<String, String> headers(String token) {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-Encoding': 'application/gzip',
      'Authorization': 'Bearer $token'
    };
  }

  Future<List> getChatPeople(String token) async {
    Response response = await http.get(
        Uri.parse(
            "https://messenger.pilotbazar.xyz/api/v1/vendor-management/contacts"),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Accept-Encoding': 'application/gzip',
          'Authorization': 'Bearer $token'
        });

    decodedBody = jsonDecode(response.body);

    for (var person in decodedBody?['people']) {
      var contact = await {
        "name": person["name"],
        "phone": person["phone"],
        "avatar": person["avatar"],
        "id": person["id"],
        "room": {
          "room_id": person['room']['id'],
          "room_name": person['room']['name'],
        }
      };

      getChatPeopleList.add(contact);
    }

    return getChatPeopleList;
  }

  Future<List> getGroup(String token) async {
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

    decodeGroupChatdBody = jsonDecode(response.body);

    for (var groups in decodeGroupChatdBody?['groups']) {
      var group = await {
        "id": groups["id"],
        "room": groups["room"],
        "message": groups["message"],

        "datetime": groups["datetime"],
        //  "avatar": groups["avatar"],
        "groups": {
          "id": groups['users'][0]['id'],
          "name": groups['users'][0]['name'],
          "avatar": groups['users'][0]['avatar'],
          "status": groups['users'][0]['status'],
        }
      };
      getGroupChatList.add(group);
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
        body: jsonEncode(body));

    print("status code is");
    print(response.statusCode);
    print("create Group");
    print(response.body);

    decodeGroupChatdBody = jsonDecode(response.body);

    return getGroupChatList;
  }

  Future<void> sendMessageMethod(
      String token, roomId, userIdManual, userId, messageFromTextFild) async {
    print(token);
    print(roomId);
    print(userIdManual);
    print("Send message methode");
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-Encoding': 'application/gzip',
      'Authorization': 'Bearer $token'
    };

    Map<String, String> body = {
      "room_id": roomId,
      "user_id": userId,
      "bracket": "T",
      "content": messageFromTextFild
    };
    Response response = await post(
        Uri.parse("$chatBaseUrl-management/messages"),
        headers: headers,
        body: jsonEncode(body));

    print("Body");
    print(body);
    final decodedBody = jsonDecode(response.body);
    print(decodedBody);
  }

  getMessageMethod(String token, roomId) async {
    Response response = await http.get(
        Uri.parse("$chatBaseUrl-management/messages?roomID=$roomId"),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Accept-Encoding': 'application/gzip',
          'Authorization': 'Bearer $token',
        });
    print("get messages status code");
    print(response.statusCode);
    print(response.body);
    decodedGetChatBody = jsonDecode(response.body);
    print(decodedGetChatBody);
    return decodedGetChatBody;
  }

  List get chatList => getChatPeopleList;
  List get chatGroup => getGroupChatList;
  List get getDecodedGetChatBody => decodedGetChatBody;
  // List get chats => getChat;
}
