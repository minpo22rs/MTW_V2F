import 'package:decimal/decimal.dart';

class Hotel {
  int id;
  String name;
  String rating;
  String location;
  String image;

  Hotel({
    required this.id,
    required this.name,
    required this.rating,
    required this.location,
    required this.image,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'] ?? '',
      name: json['shopname'] ?? '',
      rating: json['rating'],
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
