import 'package:pilot_bazar_admin/socket_io/tokens.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatEventHandler {
  final IO.Socket socket;

  ChatEventHandler(this.socket) {
    // Set up the socket event listeners
    _initializeListeners();
  }

  void _initializeListeners() {
    socket.on('reloadChat ', (data) {
      print(data);
    });
  }

  sendMessage(
    String roomName,
    roomId,
    userId,
    messageFromTextFild,
  ) {
    print("send message in handler");
    var currentIndex = {
      "room": {
        "id": roomId,
        "name": roomName,
      },
      "bracket": "T",
      "content": messageFromTextFild
    };
    socket.emit('createChat', currentIndex);
  //  print(currentIndex);

    // socket.on('isSentChat ', (data) {
    //   print("Is SentChat $data");
    // });
    print("From send message");
  }
}
