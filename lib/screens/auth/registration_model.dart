class RegistrationModel {
  String? status;
  Null? message;
  Payload? payload;

  RegistrationModel({this.status, this.message, this.payload});

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    payload =
        json['payload'] != null ? new Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.payload != null) {
      data['payload'] = this.payload!.toJson();
    }
    return data;
  }
}

class Payload {
  Merchant? merchant;
  String? token;

  Payload({this.merchant, this.token});

  Payload.fromJson(Map<String, dynamic> json) {
    merchant = json['merchant'] != null
        ? new Merchant.fromJson(json['merchant'])
        : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.merchant != null) {
      data['merchant'] = this.merchant!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class Merchant {
  String? name;
  String? mobile;
  String? updatedAt;
  String? createdAt;
  int? id;

  Merchant({this.name, this.mobile, this.updatedAt, this.createdAt, this.id});

  Merchant.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
