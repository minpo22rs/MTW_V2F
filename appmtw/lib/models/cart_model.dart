class CartModel {
  int id;
  String nameseller;
  int qty;
  int total;
  String img;
  String datetime;

  CartModel({
    required this.id,
    required this.nameseller,
    required this.qty,
    required this.total,
    required this.img,
    required this.datetime,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      nameseller: json['shopname'],
      qty: json['qty'],
      total: json['total'],
      img: json['img'],
      datetime: json['datetime'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shopname'] = this.nameseller;
    data['qty'] = this.qty;
    data['total'] = this.total;
    data['img'] = this.img;
    data['datetime'] = this.datetime;
    return data;
  }
}
