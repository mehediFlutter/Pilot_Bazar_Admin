import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ProductDTO {
  String? id;
  String? title;
  String? code;
  String? image;
  String? price;

  ProductDTO({this.id, this.title, this.code, this.image, this.price});

  factory ProductDTO.fromJson(Map<String, dynamic> data) {
    return ProductDTO(
      id    :     data['id'],
      title :     data['title'],
      code  :     data['code'],
      image :     data['image'],
      price :     data['price'],
    );
  }
}

class FeatureDTO {
  String? title;
  String? value;

  FeatureDTO({this.title, this.value});

  factory FeatureDTO.fromJson(Map<String, dynamic> data) {
    return FeatureDTO(
      title: data['title'] ?? '',
      value: data['value'] ?? '',
    );
  }
}

class SpecialDTO {
  String? title;
  List? value;

  SpecialDTO({this.title, this.value});

  factory SpecialDTO.fromJson(Map<String, dynamic> data) {
    return SpecialDTO(
      title: data['title'] ?? '',
      value: data['value'] ?? [],
    );
  }
}

class GalleryDTO {
  static String? IMG_BASE_URL = 'https://pilotbazar.com';
  static String? IMG_TEMP_URL = 'https://click4details.com';

  String? title;
  String? share;
  String? image;

  GalleryDTO({this.title, this.share, this.image});

  factory GalleryDTO.fromJson(String data) {
    return GalleryDTO(
      title: data,
      share: data.replaceAll(IMG_BASE_URL ?? '', IMG_TEMP_URL ?? ''),
      image: data.split('/').last
    );
  }
}

class VehicleDetailDTO {
  ProductDTO?       product;
  List<FeatureDTO>? feature;
  List<SpecialDTO>? special;
  List<GalleryDTO>? gallery;

  VehicleDetailDTO({this.product, this.feature, this.special, this.gallery});

  factory VehicleDetailDTO.fromObject(Map<String, dynamic> data) {
    List<FeatureDTO>? tempFeature = [];
    for (var i in data['feature']) {
      tempFeature.add(FeatureDTO.fromJson(i));
    }
    List<GalleryDTO>? tempGallery = [];
    for (var i in data['gallery']) {
      tempGallery.add(GalleryDTO.fromJson(i));
    }
    List<SpecialDTO>? tempSpecial = [];
    for (var i in data['special']) {
      tempSpecial.add(SpecialDTO.fromJson(i));
    }

    return VehicleDetailDTO(
      product: ProductDTO.fromJson(data),
      feature: tempFeature,
      special: tempSpecial,
      gallery: tempGallery,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product,
      'feature': feature,
      'special': special,
      'gallery': gallery,
    };
  }

  String toDetails() {
    List<FeatureDTO>? iterable1 = feature ?? [];
    List<SpecialDTO>? iterable2 = special ?? [];
    String response = '';

    response += "General Features ⇲\n";
    if (iterable1.isNotEmpty) {
      for (var i in iterable1) {
        response += '${i.title}: ${i.value}\n';
      }
    }

    response += "\nSpecial Features ⇲\n";
    if (iterable2.isNotEmpty) {
      for (var i in iterable2) {
        response += '${i.title}: ${i.value?.join(', ')}\n';
      }
    }

    return response;
  }

  Future<List> toGallery() async {
    List<GalleryDTO>? iterable = gallery ?? [];

    List response = [];
    if (iterable.isNotEmpty) {
      for (var i in iterable) {
        final uri = Uri.parse(i.share ?? '');
        final bit = await http.get(uri);
        final imageBytes = bit.bodyBytes;
//https://pilotbazar.com/storage/vehicles/YpgTalJBKwIXKZRG9WnDDCaFwJmzNIaI0SX1WgvX.jpg

        final tempDirectory = await getTemporaryDirectory();
        final tempFile = await File('${tempDirectory.path}/${i.title}')
            .writeAsBytes(imageBytes);

        final image = XFile(tempFile.path);
        response.add(image);
      }
    }
    return response;
  }
}
