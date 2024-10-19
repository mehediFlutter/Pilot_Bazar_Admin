class GetAllVehicleDTO {
  String? id;
  String? title;
  String? code;
  String? image;
  String? price;
  String? registration;
  String? mileage;
  String? condition;
  String? available;

  GetAllVehicleDTO(
      {
      this.id,
      this.title,
      this.code,
      this.image,
      this.price,
      this.registration,
      this.mileage,
      this.condition,
      this.available});
  factory GetAllVehicleDTO.fromObject(Map<String, dynamic> data) {
    return GetAllVehicleDTO(
      id:             data['id'] ?? 'None',
      title:          data['title'] ?? 'None',
      code:           data['code'] ?? 'None',
      image:           data['image'] ?? 'None',
      price:          data['price'] ?? 'None',
      registration:   data['registration'] ?? 'None',
      mileage:        data['mileage'] ?? 'None',
      condition:      data['condition'] ?? 'None',
      available:      data['available'] ?? 'None',
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id'              : id,
      'title'           : title,
      'code'            : code,
      'price'           : price,
      'registration'    : registration,
      'mileage'         : mileage,
      'condition'       : condition,
      'available'       : available
    };
  }
}
