import 'package:pilot_bazar_admin/package/chatting/chat_tab_bar.dart/chat_enen_handler.dart';
import 'package:pilot_bazar_admin/socket_io/socket_method.dart';
import 'package:pilot_bazar_admin/socket_io/tokens.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';
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
    initSocket();
  }

  void initSocket() async {
    socket = IO.io(
        'https://websocket.pilotbazar.xyz/vendor?token=$messengerAPIToken',
        <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': false,
          'forceNew': true,
          'reconnectionAttempts': 5,
          'debug': true, // Enable debug logging
        });

    print('$chatBaseUrl?token=$messengerAPIToken');

    chatEventHandler = ChatEventHandler(socket);

    // socket.on('msgChat', (data) {
    //   final roomName = data['room_name'];
    //   final roomId = data['room_id'];

    //   print('Message received: $data');

    //   socket.emit('sentEvent', {'room_name': roomName, 'room_id': roomId});
    // });

    socket.onConnect((_) async {
      print("Inside of on connect");

      print('Socket connected: ${socket.id}');
    });
    socket.on('joined',  (data) async => {print(data)});
    socket.on('leaved', (data) async => {print(data)});
    socket.on('myself', (data) async {
      print(data);
    });
    print('Socket connected: ${socket.id}');
    socket.on('isSentChat', (data) async {
      print(data);
    });
    socket.on('reloadChat', (data) async {
      print(data);
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
}
