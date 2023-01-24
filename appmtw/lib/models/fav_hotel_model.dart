import 'package:decimal/decimal.dart';

class HotelFav {
  int id;
  String name;
  String rating;
  String location;
  String image;

  HotelFav({
    required this.id,
    required this.name,
    required this.rating,
    required this.location,
    required this.image,
  });

  factory HotelFav.fromJson(Map<String, dynamic> json) {
    return HotelFav(
      id: json['id'] ?? '',
      name: json['shopname'] ?? '',
      rating: json['rating'] ?? '',
      location: json['position_url'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> datares = new Map<String, dynamic>();
    datares['location_id'] = this.id;
    datares['shopname'] = this.name;
    datares['rating'] = this.rating;
    datares['image'] = this.image;
    datares['position_url'] = this.location;
    return datares;
  }
}
