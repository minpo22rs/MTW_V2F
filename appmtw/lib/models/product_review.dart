class ProductReview {
  int id;
  String detial;
  String name;
  String image;
  ProductReview({
    required this.id,
    required this.detial,
    required this.name,
    required this.image,
  });
}

List<ProductReview> productreview = [
  ProductReview(
      id: 1, detial: 'เนื้อหารีวิว 1', image: 'image', name: 'ชื่อลูกค้า'),
  ProductReview(
      id: 2, detial: 'เนื้อหารีวิว 2', image: 'image', name: 'ชื่อลูกค้า'),
  ProductReview(
      id: 3, detial: 'เนื้อหารีวิว 3', image: 'image', name: 'ชื่อลูกค้า'),
  ProductReview(
      id: 4, detial: 'เนื้อหารีวิว 4', image: 'image', name: 'ชื่อลูกค้า'),
  ProductReview(
      id: 5, detial: 'เนื้อหารีวิว 5', image: 'image', name: 'ชื่อลูกค้า'),
];
