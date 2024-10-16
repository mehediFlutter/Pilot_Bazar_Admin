class OPRoomDTO {
  String? id;
  String? name;

  OPRoomDTO({this.id, this.name});

  factory OPRoomDTO.fromObject(Map<String, dynamic> data) {
    return OPRoomDTO(
      id: data['id'],
      name: data['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
 

 // Online People DTO 
class OnlinePeopleDTO {
  String? id;
  String? name;
  String? image;
  OPRoomDTO? room;

  OnlinePeopleDTO({this.id, this.name, this.image, this.room});
  

  factory OnlinePeopleDTO.fromObject(Map<String, dynamic> data) {
    return OnlinePeopleDTO(
      id: data['id'] ?? 'none',
      name: data['name'] ?? 'none',
      image: data['image'] ?? '',
      room: data['room'] != null ? OPRoomDTO.fromObject(data['room']) : null,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'room': room?.toJson(),
    };
  }

  @override
  String toString() {
    return 'Online person ID: $id,  Name: $name, room : ${room?.id}';
  }
}
