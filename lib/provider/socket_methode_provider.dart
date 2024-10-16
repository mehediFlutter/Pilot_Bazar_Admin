import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pilot_bazar_admin/DTO/contact_people.dart';
import 'package:pilot_bazar_admin/socket_io/tokens.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocketMethodeProvider extends ChangeNotifier {
  late SharedPreferences prefs;
  int _count = 0;
  int get count => _count;
  bool themeModeValue = true;

  Map<String, dynamic>? decodedBody;
  List _groupChatList = [];
  List<ContactPeopleDTO> people = [];
  List<ContactPeopleDTO> get getinboxChatListFromProvider => people;
  List get getGroupChatListFromProvider => _groupChatList;

  getInbox(String xAppContact) async {
    print("get inbox people methode");
    print(" Token: ${messengerAPIToken}, $APP_MESSENGER_URL/contacts");
    people.clear();
    Response response =
        await http.get(Uri.parse("$APP_MESSENGER_URL/contacts"), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-Encoding': 'application/gzip',
      'Authorization': 'Bearer $messengerAPIToken',
      'x-app-contact': '$xAppContact'
    });

    final jsonData = jsonDecode(response.body);
    print("people list ${jsonData}");

    for (var each in jsonData) {
      people.add(ContactPeopleDTO.fromObject(each));
    }

    //  _inboxChatList.add(contact);

    notifyListeners();

    return people;
  }

  Future<List> getGroup(String token) async {
    _groupChatList.clear();
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

    Map? decodeGroupChatdBody = jsonDecode(response.body);

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
      _groupChatList.add(group);
    }
    notifyListeners();

    return _groupChatList;
  }

  SocketMethodeProvider() {
    _loadPreferences();
  }

  void _loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
    themeModeValue = prefs.getBool('themeBool') ?? true;
    notifyListeners();
  }
}
