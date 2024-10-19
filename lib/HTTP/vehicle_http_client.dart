import 'dart:convert';
import 'package:http/http.dart';
import 'package:pilot_bazar_admin/socket_io/tokens.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class VehicleCollectionHttpClient {
  late SharedPreferences? preference;
  VehicleCollectionHttpClient() {
    _loadPreferences();
  }

  void _loadPreferences() async {
    preference = await SharedPreferences.getInstance();
  }

  process(String? token) async {
    preference = await SharedPreferences.getInstance();
    String? authToken = await preference?.getString('token');
    print("Bearer token is ${preference?.getString('token')}");

    Response response = await http.get(
      Uri.parse("$APP_APISERVER_URL/api/v1/vendor-management/vehicles"),
      headers: await {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Encoding': 'application/gzip',
        'Authorization': 'Bearer ${preference?.getString('token')}'
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Return parsed response
    } else {
      throw Exception('Failed to load vehicles'); // Handle errors
    }
  }
}

class VehicleFindOrFailHttpClient {
  static Future process(String id) async {
    late SharedPreferences? preference;

    preference = await SharedPreferences.getInstance();
    String? authToken = await preference.getString('token');

    Response response = await http.get(
      Uri.parse("$APP_APISERVER_URL/v1/vendor-management/vehicles/$id"),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Encoding': 'application/gzip',
        'Authorization': 'Bearer ${authToken}'
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Return parsed response
    } else {
      throw Exception('Failed to load vehicles'); // Handle errors
    }
  }
}
