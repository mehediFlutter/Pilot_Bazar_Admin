import 'package:pilot_bazar_admin/network_service/network_caller.dart';
import 'package:pilot_bazar_admin/socket_io/socket_method.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  static final SocketManager _instance = SocketManager._internal();
  SocketMethod socketMethod = SocketMethod();

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
    socket.on('me', (data) async {
      print('Received message: $data'); // Debug print
    });

    socket.onConnect((_) async {
      callSocketMethode() {
        socketMethod.authorizeChat();
      }

      print('Socket connected: ${socket.id}'); // Print Socket ID on connect
    });

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
