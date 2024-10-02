import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_over_view.dart';
import 'package:pilot_bazar_admin/screens/auth/auth_utility.dart';
import 'package:pilot_bazar_admin/screens/auth/loain_model.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';

class AuthMethode {
  Future login(Map body, context) async {
    body;
    Response response = await post(
        Uri.parse('${baseUrlWithAPI_EndPoint}merchant/auth/login'),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json'
        },
        body: jsonEncode(body));
    print(response.statusCode);
    if (response.statusCode == 200) {
      Map decodedBody = jsonDecode(response.body.toString());
      LoginModel model =
          LoginModel.fromJson(decodedBody.cast<String, dynamic>());
      await AuthUtility.saveUserInfo(model);
      print(model.toJson()['payload']['merchant']['name']);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => CustomerOverView()),
          (route) => false);
    }
  }
}
