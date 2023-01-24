import 'package:mtw_project/utill/images.dart';

class CategoryRestaurant {
  int id;
  String image;
  String namecatrory;

  CategoryRestaurant({
    required this.id,
    required this.image,
    required this.namecatrory,
  });

  factory CategoryRestaurant.fromJson(Map<String, dynamic> json) {
    return CategoryRestaurant(
      id: json['id'] ?? '',
      image: json['icon'] ?? '',
      namecatrory: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['icon'] = this.image;
    data['name'] = this.namecatrory;
    return data;
  }
}

// List<CategoryRestaurant> categoryrestaurants = [
//   CategoryRestaurant(image: Images.bangkok, name: 'ฟาสต์ฟู้ด'),
//   CategoryRestaurant(image: Images.central, name: 'อาหารเกาหลี'),
//   CategoryRestaurant(image: Images.easternregion, name: 'อาหารญี่ปุ่น'),
//   CategoryRestaurant(image: Images.north, name: 'อาหารไทย'),
//   CategoryRestaurant(image: Images.south, name: 'ของหวาน'),
// ];
