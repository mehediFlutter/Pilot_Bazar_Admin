class SendRoomDAO {
  String? id;
  String? name;

  SendRoomDAO({this.id, this.name});

  factory SendRoomDAO.fromParam(String id, name) {
    return SendRoomDAO(id: id, name: name);
  }

  Map<String, dynamic> toObject() {
    return {
      'room': {
        'id': id,
        'name': name,
      }
    };
  }
}

class SendChatDAO {
  String? bracket;
  String? content;

  SendChatDAO({this.bracket, this.content});

  factory SendChatDAO.fromParam(String bracket, content) {
    return SendChatDAO(bracket: bracket, content: content);
  }

  Map<String, dynamic> toObject() {
    return {
      'bracket': bracket,
      'content': content,
    };
  }
}

class SendMessageDAO {
  SendRoomDAO? room;
  SendChatDAO? chat;

  SendMessageDAO({this.room, this.chat});

  factory SendMessageDAO.fromParam(String id, name, bracket, content) {
    return SendMessageDAO(
      room: SendRoomDAO(id: id, name: name),
      chat: SendChatDAO(bracket: bracket, content: content),
    );
  }

  Map<String, dynamic> toObject() {
    return {...room!.toObject(), ...chat!.toObject()};
  }
}
