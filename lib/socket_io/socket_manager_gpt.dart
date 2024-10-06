import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManagerGPT {
  static final SocketManagerGPT _instance = SocketManagerGPT._internal();
  late IO.Socket socket;

  factory SocketManagerGPT() {
    return _instance;
  }

  SocketManagerGPT._internal() {
    print("From Socket Manager GPT");
    initSocket();
  }

  void initSocket() async {
    socket = IO.io('https://websocket.pilotbazar.xyz', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'forceNew': true,
      'reconnectionAttempts': 5,
      'debug': true, // Enable debug logging
    });

    socket.onConnect((_) async {
      print('Socket connected: ${socket.id}'); // Print Socket ID on connect
    });

    socket.onConnectError((error) {
      print('Connect error: $error'); // Debug print
    });

    socket.onDisconnect((_) {
      print('Socket disconnected'); // Debug print
    });

    socket.on('me', (data) async {
      print('Received message: $data'); // Debug print
    });

    print('Attempting to connect...'); // Debug print
    socket.connect();
  }

  // Getter to access the socket ID
  // String get socketId => socket.id; // You can access the socket ID
}
