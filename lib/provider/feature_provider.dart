import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pilot_bazar_admin/DTO/vehicle_detail_dto.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeatureProvider with ChangeNotifier {
  late SharedPreferences      preference;

  List<VehicleDetailDTO> vehicleFeature         = [];
  List vehicleSpecialFeature  = [];
  List vehicleGallery         = [];

  List get getVehicleSpecialFeature                => vehicleSpecialFeature;
  List<VehicleDetailDTO> get getVehicleFeature     => vehicleFeature;

  features(String id) async {

    preference = await SharedPreferences.getInstance();

    Response response = await get(
      Uri.parse("$APP_APISERVER_URL/api/v1/vendor-management/vehicles/$id"),
      headers: await {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Encoding': 'application/gzip',
        'Authorization': 'Bearer ${preference.getString('token')}'
      },
    );

    print("Feature status code : ${response.statusCode}");

    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    vehicleFeature = decodedResponse['feature'];
    print("Vehicle Features From DTO : ${vehicleFeature}");
    notifyListeners();

    return vehicleFeature;
  }

  specialFeatures(String id) async {
    print("Special Feature method");
    preference = await SharedPreferences.getInstance();

    Response response = await get(
      Uri.parse("$APP_APISERVER_URL/api/v1/vendor-management/vehicles/$id"),
      headers: await {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Encoding': 'application/gzip',
        'Authorization': 'Bearer ${preference.getString('token')}'
      },
    );

    print("Feature status code : ${response.statusCode}");

    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    vehicleSpecialFeature = decodedResponse['special'];
    print("Special features are ${vehicleSpecialFeature}");
    notifyListeners();

    return vehicleSpecialFeature;
  }
}
