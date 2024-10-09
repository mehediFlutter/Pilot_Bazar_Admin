import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatEventHandler {
  final IO.Socket socket;

  ChatEventHandler(this.socket) {
    // Set up the socket event listeners
    _initializeListeners();
  }

  void _initializeListeners() {
    socket.on('msgChat', (data) {
      final roomName = data['room_name'];
      final roomId = data['room_id'];

      // Log the received data (optional)
      print('Message received: $data');

      // Emit 'sentEvent' with the dynamically extracted room_name and room_id
      socket.emit('sentEvent', {'room_name': roomName, 'room_id': roomId});

      print(data);
    });
  }

  // Method to send a chat message
  void sendMessage(String message, String roomName, String roomId) {
    print("send message in handler");
    socket.emit('sendMessage',
        {'message': message, 'room_name': roomName, 'room_id': roomId});
    print('Message sent: $message to room: $roomName with roomId: $roomId');
  }
}
