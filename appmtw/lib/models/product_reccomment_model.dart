class ProductRec {
  int id;
  String name;
  int price;
  int saleprice;
  String image;

  ProductRec({
    required this.id,
    required this.name,
    required this.price,
    required this.saleprice,
    required this.image,
  });

  factory ProductRec.fromJson(Map<String, dynamic> json) {
    return ProductRec(
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
