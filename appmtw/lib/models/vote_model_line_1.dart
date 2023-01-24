class Voteline1 {
  int id;
  String name;
  int score;
  double price;
  String image;

  Voteline1({
    required this.id,
    required this.name,
    required this.score,
    required this.price,
    required this.image,
  });
}

List<Voteline1> voteline1 = [
  Voteline1(
    id: 1,
    name: 'หัวใจ',
    score: 3,
    price: 30.00,
    image: 'assets/icons/flower.png',
  ),
  Voteline1(
    id: 2,
    name: 'ดอกไม้',
    score: 5,
    price: 50.00,
    image: '',
  ),
  Voteline1(
    id: 1,
    name: 'ช่อดอกไม้',
    score: 10,
    price: 100.00,
    image: '',
  ),
  Voteline1(
    id: 1,
    name: 'มงกุฏ',
    score: 50,
    price: 500.00,
    image: '',
  ),
];
