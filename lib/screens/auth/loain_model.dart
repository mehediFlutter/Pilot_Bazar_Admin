class LoginModel {
  String? id;
  String? name;
  String? phone;
  String? token;

  LoginModel({this.id, this.name, this.phone, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['token'] = this.token;
    return data;
  }
}
