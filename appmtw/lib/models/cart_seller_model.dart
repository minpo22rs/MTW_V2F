class CartProduct {
  int id;
  String nameseller;
  bool check;

  CartProduct(
      {required this.id, required this.nameseller, required this.check});

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      id: json['id'],
      nameseller: json['shopname'],
      check: false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shopname'] = this.nameseller;
    return data;
  }
}
