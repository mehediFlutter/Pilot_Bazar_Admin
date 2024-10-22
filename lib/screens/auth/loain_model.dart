class LoginModel {
  String? id;
  String? name;
  String? phone;
  String? token;
  String? image;

  LoginModel({this.id, this.name, this.phone, this.token,this.image});

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    token = json['token'];
    token = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['token'] = this.token;
    data['image'] = this.image;
    return data;
  }
}
