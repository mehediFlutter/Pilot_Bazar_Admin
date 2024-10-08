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
  List _getChatPeopleList = [];
  List get getChatPeopleList => _getChatPeopleList;

  Future<List> getChatPeopleAndGroup(String token) async {
    print("Auth token from get chat people and group $token");
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-Encoding': 'application/gzip',
      'Authorization': 'Bearer $token'
    };
    Response response = await http.get(
        Uri.parse(
            "$chatBaseUrl-management/contacts"),
        headers: headers);

    print("Get Chat People Methode");
    print("status code is");
    print(response.statusCode);

    decodedBody = jsonDecode(response.body);
    _getChatPeopleList.clear();

    for (var person in decodedBody?['people']) {
      var contact = await {
        "name": person["name"],
        "phone": person["phone"],
        "avatar": person["avatar"],
        "id": person["id"],
      };
      _getChatPeopleList.add(contact);
    }
    for (var groups in decodedBody?['groups']) {
      var groupsIndex = {
        "id":groups['id'],
        "room":groups['room'],
        "datetime":groups['datetime'],
        "avatar": groups["avatar"],


      };
      _getChatPeopleList.add(groupsIndex);
    }
   

    return _getChatPeopleList;
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
