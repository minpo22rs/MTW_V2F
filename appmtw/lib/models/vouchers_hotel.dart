class VouchersH {
  int id;
  int productId;
  String name;
  String images;
  String statuspay;
  String orderdate;
  int pirce;

  VouchersH(
      {required this.id,
      required this.productId,
      required this.name,
      required this.images,
      required this.statuspay,
      required this.orderdate,
      required this.pirce});

  factory VouchersH.fromJson(Map<String, dynamic> json) {
    return VouchersH(
      id: json['v_id'] ?? '',
      name: json['name'] ?? '',
      productId: json['product'] ?? '',
      images: json['image'] ?? '',
      statuspay: json['status_pay'] ?? '',
      orderdate: json['o_created_at'] ?? '',
      pirce: json['purchase_price'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> datares = new Map<String, dynamic>();
    datares['v_id'] = this.id;
    datares['product'] = this.productId;
    datares['name'] = this.name;
    datares['image'] = this.images;
    datares['status_pay'] = this.statuspay;
    datares['o_created_at'] = this.orderdate;
    datares['purchase_price'] = this.pirce;
    return datares;
  }
}
