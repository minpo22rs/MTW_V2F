import 'package:mtw_project/utill/images.dart';

class CategoryProduct {
  int id;
  String image;
  String namecatrory;

  CategoryProduct({
    required this.id,
    required this.image,
    required this.namecatrory,
  });

  factory CategoryProduct.fromJson(Map<String, dynamic> json) {
    return CategoryProduct(
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

// List<CategoryProduct> categoryProduct = [
//   CategoryProduct(
//     image: Images.background,
//     namecatrory: 'เสื้อผ้าแฟชั่น',
//   ),
//   CategoryProduct(
//     image: Images.background,
//     namecatrory: 'อาหารเสริมและผลิตภัณฑ์สุขภาพ',
//   ),
//   CategoryProduct(
//     image: Images.background,
//     namecatrory: 'สินค้าท้องถิ่น',
//   ),
//   CategoryProduct(
//     image: Images.background,
//     namecatrory: 'ตั๋วและบัตรกำนัล',
//   ),
//   CategoryProduct(
//     image: Images.background,
//     namecatrory: 'ความงามและของใช้ส่วนตัว',
//   ),
//   CategoryProduct(
//     image: Images.background,
//     namecatrory: 'อาหารและเครื่องดื่ม',
//   ),
//   CategoryProduct(
//     image: Images.background,
//     namecatrory: 'เครื่องประดับ',
//   ),
//   CategoryProduct(
//     image: Images.background,
//     namecatrory: 'อื่นๆ',
//   ),
// ];
