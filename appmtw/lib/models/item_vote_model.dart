import 'package:mtw_project/utill/images.dart';

class Itemvote {
  String image;
  String name;
  int score;
  int price;
  Itemvote({
    required this.image,
    required this.name,
    required this.score,
    required this.price,
  });
}

List<Itemvote> itemvotes = [
  Itemvote(image: Images.icon_vote_1, name: 'หัวใจ', score: 10, price: 30),
  Itemvote(image: Images.icon_vote_3, name: 'ปลาคราฟ', score: 20, price: 50),
  Itemvote(image: Images.icon_vote_5, name: 'ช่อดอกไม้', score: 50, price: 100),
  Itemvote(image: Images.icon_vote_6, name: 'เป็ดน้อย', score: 300, price: 500),
  Itemvote(image: Images.icon_vote_2, name: 'ซาฟิง', score: 700, price: 1000),
  Itemvote(
      image: Images.icon_vote_4, name: 'เพชรเม็ดโต', score: 5000, price: 5000),
];
