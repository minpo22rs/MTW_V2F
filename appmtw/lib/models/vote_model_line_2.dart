class Voteline2 {
  int id;
  String name;
  int score;
  double price;
  String image;

  Voteline2({
    required this.id,
    required this.name,
    required this.score,
    required this.price,
    required this.image,
  });
}

List<Voteline2> voteline2 = [
  Voteline2(
    id: 1,
    name: 'ตบมือ',
    score: 1,
    price: 10.00,
    image: 'image',
  ),
  Voteline2(
    id: 2,
    name: 'ซุปเปอร์คาร์',
    score: 100,
    price: 1000.00,
    image: 'image',
  ),
  Voteline2(
    id: 3,
    name: 'เครื่องบิน',
    score: 100,
    price: 1000.00,
    image: 'image',
  ),
  Voteline2(
    id: 4,
    name: 'เรือยจร์ช',
    score: 100,
    price: 1000.00,
    image: 'image',
  ),
];
