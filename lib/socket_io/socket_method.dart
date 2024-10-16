import 'dart:convert';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:pilot_bazar_admin/DTO/contact_people.dart';
import 'package:pilot_bazar_admin/DTO/online_people.dart';
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
    // S.A.C automobil 01j9f3d86s4wgnnxjja828dez0
    // pilot bazar 01j9f3d858nrejs1zdz0z2kx5h
    Map<String, dynamic> body = {
      "userid": "01j9f3d858nrejs1zdz0z2kx5h",
      // "socket": "${SocketManager().socket.id}",
      "issued": "F"
    };

    Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final decodedBody = jsonDecode(response.body);
      messengerAPIToken = await decodedBody['token'];

      authorizeChatToken = await decodedBody['token']; // Correct 'tokekn' typo

      messengerAPIToken = decodedBody['token'];
    } else {
      Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );
      final decodedBody = jsonDecode(response.body);
      messengerAPIToken = await decodedBody['token'];
      authorizeChatToken = await decodedBody['token'];
    }
    await prefss.setString("authorizeChatToken", authorizeChatToken.toString());

    // if (messengerAPIToken != null) {
    //   await SocketManager();
    // }
  }

  List contactNumber = [];
  Future<void> fetchContacts() async {
    var status = await Permission.contacts.request();

    if (status.isGranted) {
      List contacts = await FlutterContacts.getContacts(withProperties: true);

      for (var contact in contacts) {
        if (contact.phones.isNotEmpty) {
          for (var phone in contact.phones) {
            contactNumber.add(phone.number);
          }
        }
      }
      print("Phone number fro fetch contact${contactNumber}");
    }
  }

  Future<void> postPhoneNumber() async {
    Map<String, dynamic> body = await {
      "group": false,
      "title": null,
      "users": contactNumber, // Use your contact list here
    };
    Response response = await http.post(
      Uri.parse(
        '$chatBaseUrl-management/contacts',
      ),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Accept-Encoding": "application/gzip",
        "Authorization": 'Bearer $messengerAPIToken'
      },
    );
  }

  List getChatPeopleList = [];
  List getGroupChatList = [];
  List<OnlinePeopleDTO> onlinePeopleList = [];
  List decodedGetChatBody = [];
  Map<String, dynamic>? decodedBody;
  Map<String, dynamic>? decodeGroupChatdBody;
  Map<String, dynamic>? decodeActiveChatBody;
  Map<String, String> headers(String token) {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-Encoding': 'application/gzip',
      'Authorization': 'Bearer $token'
    };
  }

  getChatPeople(String token) async {
    getChatPeopleList.clear();
    Response response =
        await http.get(Uri.parse("$chatBaseUrl-management/contacts"), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-Encoding': 'application/gzip',
      'Authorization': 'Bearer $token'
    });

    decodedBody = jsonDecode(response.body);

    for (var person in decodedBody?['people']) {
      var contact = await {
        "user": {
          "id": person["user"]["id"],
          "name": person["user"]["name"],
          "online": person["user"]["online"],
          "image": person["user"]["image"],
        },
        "room": {
          "room_id": person['room']['id'],
          "room_name": person['room']['name'],
        },
        "chat": {
          "bracket": person['chat']['bracket'],
          "content": person['chat']['content'],
        },
        "time": {
          "string": person['time']['string'],
          "elapse": person['time']['elapse'],
          "format": person['time']['format'],
        },
      };

      getChatPeopleList.add(contact);
    }

    return getChatPeopleList;
  }

  Future<List> getGroup(String token, xAppContact) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-Encoding': 'application/gzip',
      'Authorization': 'Bearer $token',
      'x-app-contact': '$xAppContact'
    };
    Response response = await http
        .get(Uri.parse("$chatBaseUrl-management/contacts"), headers: headers);

    decodeGroupChatdBody = jsonDecode(response.body);

    for (var groups in decodeGroupChatdBody?['groups']) {
      var group = await {
        "id": groups["id"],
        "image": groups['image'],

        "room": {"id": groups["room"]['id'], "name": groups["room"]['name']},

        "chat": {
          "bracket": groups['chat']['bracket'],
          "content": groups['chat']['content'],
        },
        "time": {
          "string": groups['time']['string'],
          "elapse": groups['time']['elapse'],
          "format": groups['time']['format'],
        },
        // "user": groups['user'],
      };
      getGroupChatList.add(group);
    }

    return getGroupChatList;
  }

  getOnlineChatPeople(String token, xAppContact) async {
    print("get online people methode");
    onlinePeopleList.clear();
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-Encoding': 'application/gzip',
      'Authorization': 'Bearer $token',
      'x-app-contact': '$xAppContact'
    };
    Response response = await http
        .get(Uri.parse("${chatBaseUrl}-management/contacts"), headers: headers);

    final decodeActiveChatBody = jsonDecode(response.body);

    for (var each in decodeActiveChatBody) {
      onlinePeopleList.add(OnlinePeopleDTO.fromObject(each));
    }

    return onlinePeopleList;
  }

  Future<List> createGrop(String token, Map body) async {
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

    if (response.statusCode == 200) {}

    decodeGroupChatdBody = jsonDecode(response.body);

    return getGroupChatList;
  }

  Future<void> sendMessageMethod(
      String roomId, userId, messageFromTextFild) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-Encoding': 'application/gzip',
      'Authorization': 'Bearer $messengerAPIToken'
    };

    Map body = {
      "room_id": roomId,
      "user_id": userId,
      "bracket": "T",
      "content": messageFromTextFild
    };
    Response response = await post(
        Uri.parse("$chatBaseUrl-management/messages"),
        headers: headers,
        body: jsonEncode(body));

    final decodedBody = jsonDecode(response.body);
  }

  getMessageMethod(String token, roomId) async {
    Response response = await http.get(
        Uri.parse("$chatBaseUrl-management/contacts/$roomId/messages"),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Accept-Encoding': 'application/gzip',
          'Authorization': 'Bearer $token',
        });

    final decodedGetChatBody = jsonDecode(response.body);
    print(decodedGetChatBody);

    print(
        "Decoded Message body length: ${decodedGetChatBody} : Body is: $decodedGetChatBody");
    for (var messge in decodedGetChatBody) {}
    return decodedGetChatBody;
  }

  List get chatList => getChatPeopleList;
  List get chatGroup => getGroupChatList;
  List get getDecodedGetChatBody => decodedGetChatBody;
  List get getOnlinePeopleList => onlinePeopleList;
}
