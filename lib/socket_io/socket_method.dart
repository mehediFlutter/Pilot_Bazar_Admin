import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pilot_bazar_admin/socket_io/socket_manager_gpt.dart';

class SocketMethod {
  static final SocketMethod socketMethod = SocketMethod();

 // var socket = SocketMethod().socket;
  Future authorizeChatToken() async {
 
  final url = 'https://messenger.pilotbazar.xyz/api/v1/vendor-management/authorize';
  final headers = {
    "Accept":"application/json",
    'Content-Type': 'application/json',
    "Accept-Encoding":"application/gzip"
  };
  Map<String, dynamic> body= {
    "userid": "01j9f3d86s4wgnnxjja828dez0",
    "socket": "${SocketManager().socket.id}",
    "issued": "F"
};


  Response response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: jsonEncode(body),
  );
  
  print("Chat Athorize Methode body");
  print(response.statusCode);
  print(response.body.toString());

  if (response.statusCode == 200) {
     print(response.body.toString());
    print('POST request successful!');
    print('Response: ${response.body}');
  } else {
    print('Error: ${response.statusCode}');
  }
}
}