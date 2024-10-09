import 'dart:convert';

import 'package:pilot_bazar_admin/package/chatting/chat_tab_bar.dart/chat_enen_handler.dart';
import 'package:pilot_bazar_admin/socket_io/socket_method.dart';
import 'package:pilot_bazar_admin/socket_io/tokens.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  static final SocketManager _instance = SocketManager._internal();
  SocketMethod socketMethod = SocketMethod();
  late ChatEventHandler chatEventHandler;
  late IO.Socket socket;

  factory SocketManager() {
    return _instance;
  }

  SocketManager._internal() {
    print("From Socket Manager GPT");
    initSocket();
  }

  void initSocket() async {
    socket = IO.io('https://websocket.pilotbazar.xyz/vendor', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'forceNew': true,
      'reconnectionAttempts': 5,
      'debug': true, // Enable debug logging
    });

    chatEventHandler = ChatEventHandler(socket);

    socket.on('msgChat', (data) {
      // Extract room_name and room_id from the incoming data
      final roomName =
          data['room_name']; // Assuming 'room_name' comes from the data
      final roomId = data['room_id']; // Assuming 'room_id' comes from the data

      // Log the received data (optional)
      print('Message received: $data');

      // Emit 'sentEvent' with the dynamically extracted room_name and room_id
      socket.emit('sentEvent', {'room_name': roomName, 'room_id': roomId});
    });

    // socket.on('me', (data) async {
    //   print('Received message: $data'); // Debug print
    // });

    socket.onConnect((_) async {
      await socketMethod.authorizeChat();
      await socketMethod.fetchContacts();
      await socketMethod.postPhoneNumber();

      socket.on('join', (data) => {print(data)});

      print('Socket connected: ${socket.id}');

      // Print Socket ID on connect
    });

    // socket.on('loadEvent', (data) {
    //   print(data);
    //   final res = jsonDecode(data);
    //   print(res['uuid']);
    //   SocketMethod().getMessageMethod(
    //     messengerAPIToken??"",
    //     res['uuid'],
    //   );
    // });

    socket.onConnectError((error) {
      print('Connect error: $error'); // Debug print
    });

    socket.onDisconnect((_) {
      print('Socket disconnected'); // Debug print
    });

    print('Attempting to connect...'); // Debug print
    socket.connect();
  }

  // Getter to access the socket ID
  // String get socketId => socket.id; // You can access the socket ID
}
