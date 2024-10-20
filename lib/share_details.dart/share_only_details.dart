import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pilot_bazar_admin/socket_io/tokens.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';

class ShareOnlyDetails {
  feature(String id, token) async {
    print("Token is : ${token}");
    print(id);
    String featureAsString;
    List<String> formattedSpecialFeatures = [];
    List<String> formattedFeatures = [];

    Response response = await http.get(
      Uri.parse('${APP_APISERVER_URL}/api/v1/vendor-management/vehicles/$id'),
      headers: await {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Encoding': 'application/gzip',
        'Authorization': 'Bearer $token'
      },
    );
    final decodedBody = jsonDecode(response.body);

    final decodedBodyFeature = decodedBody['feature'];

    for (var feature in decodedBodyFeature) {
      String formattedFeature = '${feature['title']}: ${feature['value']}';
      formattedFeatures.add(formattedFeature);
    }
    String featureValues = formattedFeatures.join(', ');
    

// store special feature
    final decodedBodySpecialFeature = decodedBody['special'];
    for (var i in decodedBodySpecialFeature) {
      String values = i['value'] is List
          ? (i['value'] as List).join(', ')
          : i['value'].toString();

      String formattedSpecialFeature = '${i['title']}: $values';
      formattedSpecialFeatures.add(formattedSpecialFeature);
    }
    String specialFeatureValues = formattedSpecialFeatures.join(', ');
    print(specialFeatureValues);

    return decodedBodyFeature;
  }

  specialFeature(String id) async {
    print("special feature method ");
    Response response = await http.get(
      Uri.parse('${APP_APISERVER_URL}/api/v1/vendor-management/vehicles/$id'),
      headers: await {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Encoding': 'application/gzip',
        'Authorization': 'Bearer ${loginToken}'
      },
    );
    final decodedBody = jsonDecode(response.body);

    final decodedBodySpecialFeature = decodedBody['special'];

    return decodedBodySpecialFeature;
  }
}
