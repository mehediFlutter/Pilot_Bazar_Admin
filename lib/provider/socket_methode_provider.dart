import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocketMethodeProvider extends ChangeNotifier {
  late SharedPreferences prefs;
  int _count = 0;
  int get count => _count;
  bool themeModeValue = true;

  Map<String, dynamic>? decodedBody;
  List _inboxChatList = [];
  List _groupChatList = [];
  List get getinboxChatListFromProvider => _inboxChatList;
  List get getGroupChatListFromProvider => _groupChatList;

   getInbox(String token) async {
    _inboxChatList.clear();
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

      _inboxChatList.add(contact);
    }

    notifyListeners();

    return _inboxChatList;
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
