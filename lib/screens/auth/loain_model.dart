class LoginModel {
  String? status;
  Null? message;
  Payload? payload;

  LoginModel({this.status, this.message, this.payload});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? mobile;
  Null? mobileVerifiedAt;
  int? status;
  String? merchantType;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  MerchantInfo? merchantInfo;

  Merchant(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.mobile,
      this.mobileVerifiedAt,
      this.status,
      this.merchantType,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.merchantInfo});

  Merchant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    mobile = json['mobile'];
    mobileVerifiedAt = json['mobile_verified_at'];
    status = json['status'];
    merchantType = json['merchant_type'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    merchantInfo = json['merchant_info'] != null
        ? new MerchantInfo.fromJson(json['merchant_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['mobile'] = this.mobile;
    data['mobile_verified_at'] = this.mobileVerifiedAt;
    data['status'] = this.status;
    data['merchant_type'] = this.merchantType;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.merchantInfo != null) {
      data['merchant_info'] = this.merchantInfo!.toJson();
    }
    return data;
  }
}

class MerchantInfo {
  int? id;
  int? merchantId;
  Null? address;
  String? website;
  Null? facebook;
  Null? youtube;
  String? location;
  String? companyName;
  String? createdAt;
  String? updatedAt;
  MerchantImage? merchantImage;

  MerchantInfo(
      {this.id,
      this.merchantId,
      this.address,
      this.website,
      this.facebook,
      this.youtube,
      this.location,
      this.companyName,
      this.createdAt,
      this.updatedAt,
      this.merchantImage});

  MerchantInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    merchantId = json['merchant_id'];
    address = json['address'];
    website = json['website'];
    facebook = json['facebook'];
    youtube = json['youtube'];
    location = json['location'];
    companyName = json['company_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    merchantImage = json['image'] != null
        ? new MerchantImage.fromJson(json['image'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['merchant_id'] = this.merchantId;
    data['address'] = this.address;
    data['website'] = this.website;
    data['facebook'] = this.facebook;
    data['youtube'] = this.youtube;
    data['location'] = this.location;
    data['company_name'] = this.companyName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.merchantImage != null) {
      data['image'] = this.merchantImage!.toJson();
    }
    return data;
  }
}

class MerchantImage {
  int? id;
  String? imageType;
  int? imageId;
  String? disk;
  String? name;
  String? path;
  String? mime;
  String? size;
  String? createdAt;
  String? updatedAt;

  MerchantImage(
      {this.id,
      this.imageType,
      this.imageId,
      this.disk,
      this.name,
      this.path,
      this.mime,
      this.size,
      this.createdAt,
      this.updatedAt});

  MerchantImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageType = json['image_type'];
    imageId = json['image_id'];
    disk = json['disk'];
    name = json['name'];
    path = json['path'];
    mime = json['mime'];
    size = json['size'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_type'] = this.imageType;
    data['image_id'] = this.imageId;
    data['disk'] = this.disk;
    data['name'] = this.name;
    data['path'] = this.path;
    data['mime'] = this.mime;
    data['size'] = this.size;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
