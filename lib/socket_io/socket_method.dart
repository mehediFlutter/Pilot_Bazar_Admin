import 'dart:convert';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:pilot_bazar_admin/DTO/online_people.dart';
import 'package:pilot_bazar_admin/screens/auth/auth_utility.dart';
import 'package:pilot_bazar_admin/screens/auth/loain_model.dart';
import 'package:pilot_bazar_admin/socket_io/tokens.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocketMethod {
  String? authorizeChatToken;
  Map? syncBodyContactNumbers;
  late SharedPreferences preference;
  // loadUserInfo() async {
  //   LoginModel user = await AuthUtility.getUserInfo();
  //   userInfo = user.toJson();
  // }
  Future authorizeChat() async {
    preference = await SharedPreferences.getInstance();
    LoginModel user = await AuthUtility.getUserInfo();
    print("login token authorizeChat method ${preference.getString('token')}");

    final url = '$APP_MESSENGER_URL/authorize';
    final headers = {
      "Accept": "application/json",
      'Content-Type': 'application/json',
      "Accept-Encoding": "application/gzip"
    };
    // S.A.C automobil 01j9f3d86s4wgnnxjja828dez0
    // pilot bazar 01j9f3d858nrejs1zdz0z2kx5h
    print("User id for Authorize ${user.id}");
    Map<String, dynamic> body = {"userid": user.id,
     "device": "${preference.getString('token')}",
     "issued": "F"};

    Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
    print("Response : ${response.body}");

    if (response.statusCode == 200) {
      final decodedBody = jsonDecode(response.body);
      messengerAPIToken = await decodedBody['token'];

      authorizeChatToken = await decodedBody['token']; // Correct 'tokekn' typo

      messengerAPIToken = decodedBody['token'];
    } else {
      Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );
      final decodedBody = jsonDecode(response.body);
      messengerAPIToken = await decodedBody['token'];
      authorizeChatToken = await decodedBody['token'];
    }
    await preference.setString("authorizeChatToken", authorizeChatToken.toString());

    // if (messengerAPIToken != null) {
    //   await SocketManager();
    // }
  }

  List contactNumber = [];
  Future<void> fetchContacts() async {
    var status = await Permission.contacts.request();

    if (status.isGranted) {
      List contacts = await FlutterContacts.getContacts(withProperties: true);

      for (var contact in contacts) {
        if (contact.phones.isNotEmpty) {
          for (var phone in contact.phones) {
            contactNumber.add(phone.number);
          }
        }
      }
      print("Phone number fro fetch contact${contactNumber}");
    }
  }

  Future<void> postPhoneNumber() async {
    Map<String, dynamic> body = await {
      "group": false,
      "title": null,
      "users": contactNumber, // Use your contact list here
    };
    Response response = await http.post(
        Uri.parse(
          '$APP_MESSENGER_URL/contacts',
        ),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Accept-Encoding": "application/gzip",
          "Authorization": 'Bearer $messengerAPIToken'
        },
        body: jsonEncode(body));
  }

  List getChatPeopleList = [];
  List getGroupChatList = [];
  List<OnlinePeopleDTO> onlinePeopleList = [];
  List decodedGetChatBody = [];
  Map<String, dynamic>? decodedBody;
  Map<String, dynamic>? decodeGroupChatdBody;
  Map<String, dynamic>? decodeActiveChatBody;
  Map<String, String> headers(String token) {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-Encoding': 'application/gzip',
      'Authorization': 'Bearer $token'
    };
  }

  getChatPeople(String xAppContact) async {
    getChatPeopleList.clear();
    Response response =
        await http.get(Uri.parse("$APP_MESSENGER_URL/contacts"), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-Encoding': 'application/gzip',
      'Authorization': 'Bearer $messengerAPIToken',
      'x-app-contact': xAppContact
    });

    final decodedBody = jsonDecode(response.body);
    print('Get Chat people List ${decodedBody}');

    if (decodedBody != null) {
      for (var person in decodedBody) {
        var contact = await {
          "user": {
            "id": person["user"]["id"],
            "name": person["user"]["name"],
            "online": person["user"]["online"],
            "image": person["user"]["image"],
          },
          "room": {
            "room_id": person['room']['id'],
            "room_name": person['room']['name'],
          },
          "chat": {
            "bracket": person['chat']['bracket'],
            "content": person['chat']['content'],
          },
          "time": {
            "string": person['time']['string'],
            "elapse": person['time']['elapse'],
            "format": person['time']['format'],
          },
        };

        getChatPeopleList.add(contact);
      }
    }

    return getChatPeopleList;
  }

  Future<List> getGroup(String xAppContact) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-Encoding': 'application/gzip',
      'Authorization': 'Bearer $messengerAPIToken',
      'x-app-contact': '$xAppContact'
    };
    Response response = await http
        .get(Uri.parse("$chatBaseUrl-management/contacts"), headers: headers);

    final decodeGroupChatdBody = jsonDecode(response.body);

    for (var groups in decodeGroupChatdBody) {
      var group = await {
        "id": groups["id"],
        "image": groups['image'],
        "room": {"id": groups['room']['id'], "name": groups["room"]['name']},
        "chat": {
          "bracket": groups['chat']['bracket'],
          "content": groups['chat']['content'],
        },
        "time": {
          "string": groups['time']['string'],
          "elapse": groups['time']['elapse'],
          "format": groups['time']['format'],
        },
      };
      getGroupChatList.add(group);
    }

    return getGroupChatList;
  }

  getOnlineChatPeople(String token, xAppContact) async {
    onlinePeopleList.clear();
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-Encoding': 'application/gzip',
      'Authorization': 'Bearer $token',
      'x-app-contact': '$xAppContact'
    };
    Response response = await http
        .get(Uri.parse("${chatBaseUrl}-management/contacts"), headers: headers);

    final decodeActiveChatBody = jsonDecode(response.body);

    for (var each in decodeActiveChatBody) {
      onlinePeopleList.add(OnlinePeopleDTO.fromObject(each));
    }

    return onlinePeopleList;
  }

  Future<List> createGrop(String token, Map body) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-Encoding': 'application/gzip',
      'Authorization': 'Bearer $token'
    };
    Response response = await http.post(
        Uri.parse(
            "https://messenger.pilotbazar.xyz/api/v1/vendor-management/contacts"),
        headers: headers,
        body: jsonEncode(body));

    if (response.statusCode == 200) {}

    decodeGroupChatdBody = jsonDecode(response.body);

    return getGroupChatList;
  }

  Future<void> sendMessageMethod(
      String roomId, userId, messageFromTextFild) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-Encoding': 'application/gzip',
      'Authorization': 'Bearer $messengerAPIToken'
    };

    Map body = {
      "room_id": roomId,
      "user_id": userId,
      "bracket": "T",
      "content": messageFromTextFild
    };
    Response response = await post(
        Uri.parse("$chatBaseUrl-management/messages"),
        headers: headers,
        body: jsonEncode(body));

    final decodedBody = jsonDecode(response.body);
  }

  getMessageMethod(String token, roomId) async {
    Response response = await http.get(
        Uri.parse("$chatBaseUrl-management/contacts/$roomId/messages"),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Accept-Encoding': 'application/gzip',
          'Authorization': 'Bearer $token',
        });

    final decodedGetChatBody = jsonDecode(response.body);

    // for (var messge in decodedGetChatBody['chat']) {
    //   print(messge);
    // }
    return decodedGetChatBody;
  }

  List get chatList => getChatPeopleList;
  List get chatGroup => getGroupChatList;
  List get getDecodedGetChatBody => decodedGetChatBody;
  List get getOnlinePeopleList => onlinePeopleList;
}
