import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {
  SharedPreferences? preferences;
  List? profileDetails;
  List? get getProfileDetails => profileDetails;
  getProfile() async {
    preferences = await SharedPreferences.getInstance();
    Response response = await http.get(
        Uri.parse('$APP_APISERVER_URL/api/v1/vendor-management/profile'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Accept-Encoding': 'application/gzip',
          'Authorization': 'Bearer ${preferences?.getString('token')}'
        });
    print(response.body);

    notifyListeners();
    return jsonDecode(response.body);
  }
}
