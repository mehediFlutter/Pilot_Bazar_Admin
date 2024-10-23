class ProfileDTO {
  String? name;
  String? email;
  String? phone;

  ProfileDTO({this.name, this.email, this.phone});

  factory ProfileDTO.fromObject(data) {
    return ProfileDTO(
      name: data?['name'] ?? 'None',
      email: data?['email'] ?? 'None',
      phone: data?['phone'] ?? 'None',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'phone': phone};
  }
}
