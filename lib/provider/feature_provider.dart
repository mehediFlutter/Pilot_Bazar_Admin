import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeatureProvider with ChangeNotifier {
  late SharedPreferences preference;

  List vehicleFeature = [];
  List vehicleSpecialFeature = [];
  List vehicleGallery = [];
  String feature = '';
  String specialFeature = '';
  String totalFeature = '';
  static List<XFile> showImageList = [];
  List decodedBodyGallery =[];

  List get getVehicleFeature => vehicleFeature;
  List get getVehicleSpecialFeature => vehicleSpecialFeature;
  List get getVehicleGallery => vehicleGallery;
  String get getFeature => feature;
  String get getSpecialFeature => specialFeature;
  List get getGallery => decodedBodyGallery;

  Future<void> sendAllImages(String id, List gallery) async {
    SharedPreferences? preferences;
    preferences = await SharedPreferences.getInstance();

    try {
      // Fetch vehicle details
      // Download images concurrently
      List<Future<XFile>> downloadFutures = gallery.map((imageUrl) async {
        final uri = Uri.parse(imageUrl);
        final response = await http.get(uri);
        final imageBytes = response.bodyBytes;

        final tempDirectory = await getTemporaryDirectory();
        final tempFile =
            await File('${tempDirectory.path}/${gallery.indexOf(imageUrl)}.jpg')
                .writeAsBytes(imageBytes);

        return XFile(tempFile.path);
      }).toList();

      // Await all downloads
      showImageList = await Future.wait(downloadFutures);

      if (showImageList.isNotEmpty) {
        await Share.shareXFiles(showImageList);
      }
    } catch (error) {
      // Handle or log error
      print('Error occurred while sharing images: $error');
    }
  }

  features(String id) async {
    preference = await SharedPreferences.getInstance();
    print(id);

    Response response = await get(
      Uri.parse("$APP_APISERVER_URL/api/v1/vendor-management/vehicles/$id"),
      headers: await {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Encoding': 'application/gzip',
        'Authorization': 'Bearer ${preference.getString('token')}'
      },
    );
    print(response.body);

    print("Feature status code : ${response.statusCode}");

    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    vehicleFeature = decodedResponse['feature'];
    vehicleSpecialFeature = decodedResponse['special'];
    vehicleGallery = decodedResponse['gallery'];

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

  featureProvider(String? id, token) async {
    print(token);
    List<String> formattedSpecialFeatures = [];
    List<String> formattedFeatures = [];
    formattedSpecialFeatures.clear();
    formattedFeatures.clear();

    Response response = await http.get(
      Uri.parse('${APP_APISERVER_URL}/api/v1/vendor-management/vehicles/$id'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Encoding': 'application/gzip',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final decodedBody = jsonDecode(response.body);
      final decodedBodyFeature = decodedBody['feature'];
      final decodedBodySpecialFeature = decodedBody['special'];
       decodedBodyGallery = decodedBody['gallery'];

      Map<String, String> featuresMap = {};
      for (var item in decodedBodyFeature) {
        String title = item['title'];
        String value = item['value'];
        featuresMap[title] = value;
      }
      feature = featuresMap.entries
          .map((entry) => '${entry.key} : ${entry.value}')
          .join(', ');

      for (var item in decodedBodySpecialFeature) {
        String title = item['title'];
        List<dynamic> values = item['value']; // Assuming value is a list
        String formattedValue = values.join(', '); // Join list items
        formattedSpecialFeatures
            .add('$title: $formattedValue'); // Format as "title: value"
      }
      specialFeature = formattedSpecialFeatures.join(', ');
      totalFeature = feature + specialFeature;
    } else {
      // Handle the error accordingly
      print('Error: ${response.statusCode}');
    }
    return totalFeature;
  }
}
