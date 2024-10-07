import 'dart:convert';
import 'package:http/http.dart';
import 'package:pdf/widgets.dart';
import 'package:pilot_bazar_admin/network_service/network_response.dart';
import 'package:pilot_bazar_admin/screens/auth/auth_utility.dart';

class NetworkCaller {
  Future<NetworkResponse> getRequest(
      String url, Map<String, String> header) async {
    try {
      Response response = await get(Uri.parse(url), headers: header);
      //{'token': AuthUtility.userInfo.payload!.token.toString()}
      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      } else {
        return NetworkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      print(e.toString());
    }
    return NetworkResponse(false, -1, null);
  }

  // Post()
  Future<NetworkResponse> postRequest(
      String url, Map<String, dynamic> body,{Map<String,String>? header}) async {
    try {
      Response response = await post(Uri.parse(url),
          headers: header,
          
          // headers: {
          //   'Content-Type': 'application/json',
          //   'token': AuthUtility.userInfo.payload!.token.toString()
          // },
          body: jsonEncode(body));
      print(response.statusCode);
      print(response.body.toString());

      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        gotoLogin();
      } else {
        return NetworkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      print(e.toString());
    }
    return NetworkResponse(false, -1, null);
  }

  Future<NetworkResponse> newlyRegisterLogin(
      String url, Map<String, dynamic> body) async {
    try {
      Response response = await post(Uri.parse(url),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json'
          },
          body: jsonEncode(body));
      print(response.statusCode);
      print(response.body.toString());

      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        gotoLogin();
      } else {
        return NetworkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      print(e.toString());
    }
    return NetworkResponse(false, -1, null);
  }

  Future<void> gotoLogin() async {
    await AuthUtility.clearUserInfo();
  }
}
