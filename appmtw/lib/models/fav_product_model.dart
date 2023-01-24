class ProductFav {
  int id;
  String name;
  int price;
  int saleprice;
  String image;
  bool fav;

  ProductFav({
    required this.id,
    required this.name,
    required this.price,
    required this.saleprice,
    required this.image,
    required this.fav,
  });

  factory ProductFav.fromJson(Map<String, dynamic> json) {
    return ProductFav(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: json['unit_price'] ?? '',
      saleprice: json['purchase_price'] ?? '',
      image: json['thumbnail'] ?? '',
      fav: true,
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
