import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';
import 'package:share_plus/share_plus.dart';

class ShareOnlyDetails {
  feature(String? id, String? token) async {
    List<String> formattedSpecialFeatures = [];
    List<String> formattedFeatures = [];

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

      Map<String, String> featuresMap = {};
      for (var item in decodedBodyFeature) {
        String title = item['title'];
        String value = item['value'];
        featuresMap[title] = value;
      }
      String features = featuresMap.entries
          .map((entry) => '${entry.key} : ${entry.value}')
          .join(', ');

      // if special feature is available

      for (var item in decodedBodySpecialFeature) {
        String title = item['title'];
        List<dynamic> values = item['value']; // Assuming value is a list
        String formattedValue = values.join(', '); // Join list items
        formattedSpecialFeatures
            .add('$title: $formattedValue'); // Format as "title: value"
      }
      String specialFeatures = formattedSpecialFeatures.join(', ');

      await Share.share(features + specialFeatures);
    } else {
      // Handle the error accordingly
      print('Error: ${response.statusCode}');
    }
  }

  shareDetailsWithOneImage(String? token, imageLink, details) async {
    print("details ${details}");
    final uri = Uri.parse(imageLink);
    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Encoding': 'application/gzip',
        'Authorization': 'Bearer $token'
      },
    );
    final imageBytes = response.bodyBytes;
    final tempDirectory = await getTemporaryDirectory();
    final tempFile =
        await File('${tempDirectory.path}/sharedImage.jpg').create();
    await tempFile.writeAsBytes(imageBytes);

    //await getDetails(widget.id);
    final image = XFile(tempFile.path);

    await Share.shareXFiles([image], text: details);
  }
}
