class ProductCart {
  int id;
  int cartId;
  int seller;
  int qty;
  String name;
  int price;
  int saleprice;
  String image;
  bool check;

  ProductCart({
    required this.id,
    required this.cartId,
    required this.seller,
    required this.qty,
    required this.name,
    required this.price,
    required this.saleprice,
    required this.image,
    required this.check,
  });

  factory ProductCart.fromJson(Map<String, dynamic> json) {
    return ProductCart(
      id: json['id'] ?? '',
      cartId: json['cart_id'] ?? '',
      seller: json['seller'] ?? '',
      qty: json['qty'] ?? 0,
      name: json['name'] ?? '',
      price: json['unit_price'] ?? '',
      saleprice: json['purchase_price'] ?? '',
      image: json['thumbnail'] ?? '',
      check: false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cart_id'] = this.cartId;
    data['seller'] = this.seller;
    data['qty'] = this.qty;
    data['name'] = this.name;
    data['unit_price'] = this.price;
    data['purchase_price'] = this.saleprice;
    data['thumbnail'] = this.image;
    return data;
  }
}
