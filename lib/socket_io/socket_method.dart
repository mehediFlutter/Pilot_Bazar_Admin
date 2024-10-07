import 'dart:convert';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:pilot_bazar_admin/socket_io/socket_manager.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';

class SocketMethod {
  String? authorizeChatToken;
  Map? syncContactNumbers;

  Future authorizeChat() async {
    final url = '$chatBaseUrl/api/v1/vendor-management/authorize';
    final headers = {
      "Accept": "application/json",
      'Content-Type': 'application/json',
      "Accept-Encoding": "application/gzip"
    };
    Map<String, dynamic> body = {
      "userid": "01j9f3d86s4wgnnxjja828dez0",
      "socket": "${SocketManager().socket.id}",
      "issued": "F"
    };

    Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final decodedBody = jsonDecode(response.body);
      authorizeChatToken = await decodedBody['token']; // Correct 'tokekn' typo
      print(" From Auth chat ");
      print("Authorize Token From AuthorizeChat Methode $authorizeChatToken");
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  List contactNumber = [];
  Future<void> fetchContacts() async {
    var status = await Permission.contacts.request();

    if (status.isGranted) {
      // Fetch all contacts
      List contacts = await FlutterContacts.getContacts(withProperties: true);

      contacts.forEach((contact) {
        if (contact.phones.isNotEmpty) {
          contactNumber
              .add(contact.phones[0].number); // Add the first phone number
        }
      });

      print(contactNumber);
    }
  }

  Future<void> postPhoneNumber() async {
    Map<String, dynamic> body = {
    "is_group": false,
    "contacts": contactNumber,  // Use your contact list here
  };
    Response response = await http.post(
      Uri.parse(
        'https://messenger.pilotbazar.xyz/api/v1/vendor-management/contacts',
      ),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Accept-Encoding": "application/gzip",
        "Authorization": 'Bearer $authorizeChatToken'
      },
   
      body: jsonEncode(body),
    );

    print(response.body);
    print("Post PHone number chat token is ");
    print(authorizeChatToken);
  }
}
