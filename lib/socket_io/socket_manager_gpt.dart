// import 'package:pilot_bazar_admin/package/chatting/chat_tab_bar.dart/chat_enen_handler.dart';
// import 'package:pilot_bazar_admin/socket_io/socket_method.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class SocketManager {
//   static final SocketManager _instance = SocketManager._internal();
//   SocketMethod socketMethod = SocketMethod();

//   late IO.Socket socket;
//   late ChatEventHandler chatEventHandler; // Declare ChatEventHandler

//   factory SocketManager() {
//     return _instance;
//   }

//   SocketManager._internal() {
//     print("From Socket Manager GPT");
//     initSocket();
//   }

//   void initSocket() async {
//     socket = IO.io('https://websocket.pilotbazar.xyz/vendor', <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': false,
//       'forceNew': true,
//       'reconnectionAttempts': 5,
//       'debug': true, // Enable debug logging
//     });
//     chatEventHandler = ChatEventHandler(socket);

//     // socket.on('msgChat', (data) {
//     //   // Extract room_name and room_id from the incoming data
//     //   final roomName =
//     //       data['room_name']; // Assuming 'room_name' comes from the data
//     //   final roomId = data['room_id']; // Assuming 'room_id' comes from the data

//     //   // Log the received data (optional)
//     //   print('Message received: $data');

//     //   // Emit 'sentEvent' with the dynamically extracted room_name and room_id
//     //  // socket.emit('sentEvent', {'room_name': roomName, 'room_id': roomId});
//     // });

//     socket.onConnect((_) async {
//       callSocketMethode() {
//         socketMethod.authorizeChat();
//       }

//       // Print Socket ID on connect
//     });

//     socket.onConnectError((error) {
//       print('Connect error: $error'); // Debug print
//     });

//     socket.onDisconnect((_) {
//       print('Socket disconnected'); // Debug print
//     });

//     print('Attempting to connect...'); // Debug print
//     socket.connect();
//   }

//   // sendMessage(String message, String roomName, String roomId) {
//   //   if (message.isNotEmpty) {
//   //     socket.emit('msgChat',
//   //         {'message': message, 'room_name': roomName, 'room_id': roomId});
//   //   } else {
//   //     print('Message is empty. Cannot send.');
//   //   }
//   // }

//   // Getter to access the socket ID
//   // String get socketId => socket.id; // You can access the socket ID
// }
