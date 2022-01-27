
import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String name;
  GeoPoint geoCode;
  String address;
  String rating;
  String openHours;
  String mapName;
  List<String> images;

  Category(
      {required this.name,
      required this.address,
      required this.mapName,
      required this.rating,
      required this.geoCode,
      required this.images,
      required this.openHours});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      address: json['address'],
      mapName: json['map_name'],
      rating: json['rating'],
      geoCode: json['geocode'],
      images: json['images'],
      openHours: json['open_hours']
    );
  }
}
