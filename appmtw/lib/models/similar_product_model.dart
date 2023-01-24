class SimilarProduct {
  int id;
  String name;
  int price;
  int saleprice;
  String image;

  SimilarProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.saleprice,
    required this.image,
  });

  factory SimilarProduct.fromJson(Map<String, dynamic> json) {
    return SimilarProduct(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: json['unit_price'] ?? '',
      saleprice: json['purchase_price'] ?? '',
      image: json['thumbnail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['unit_price'] = this.price;
    data['purchase_price'] = this.saleprice;
    data['thumbnail'] = this.image;
    return data;
  }
}

// List<SimilarProduct> similarproduct = [
//   SimilarProduct(
//       id: 1,
//       name: 'name1xxxxxxxxxxxname1xxxxxxxxxxx',
//       price: 100,
//       saleprice: 50,
//       image: 'image'),
//   SimilarProduct(
//       id: 2, name: 'name2', price: 100, saleprice: 50, image: 'image'),
//   SimilarProduct(
//       id: 3, name: 'name3', price: 100, saleprice: 50, image: 'image'),
//   SimilarProduct(
//       id: 4, name: 'name4', price: 100, saleprice: 50, image: 'image'),
//   SimilarProduct(
//       id: 5, name: 'name5', price: 100, saleprice: 50, image: 'image'),
// ];
