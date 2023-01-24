class Vouchers {
  String images;
  String name;
  int score;
  String exp;
  Vouchers({
    required this.images,
    required this.name,
    required this.score,
    required this.exp,
  });
}

List<Vouchers> vouchers = [
  Vouchers(images: 'images', name: 'name', score: 300, exp: 'exp'),
  Vouchers(images: 'images', name: 'name', score: 300, exp: 'exp'),
  Vouchers(images: 'images', name: 'name', score: 300, exp: 'exp'),
  Vouchers(images: 'images', name: 'name', score: 300, exp: 'exp'),
  Vouchers(images: 'images', name: 'name', score: 300, exp: 'exp'),
];
