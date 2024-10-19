class ContactPeopleDTO {
  String? id;
  String? name;
  String? phone;
  String? token;

  ContactPeopleDTO({this.id, this.name, this.phone, this.token});

  factory ContactPeopleDTO.fromObject(Map<String, dynamic> data) {
    return ContactPeopleDTO(
        id: data['id'] ?? 'None',
        name: data['name'] ?? 'None',
        phone: data['phone'] ?? 'None',
        token: data['token'] ?? 'None');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'phone': phone, 'token': token};
  }

  @override
  String toString() {
    return 'Id: $id,  Name: $name, Token: ${token}, phone: ${phone}';
  }
}
