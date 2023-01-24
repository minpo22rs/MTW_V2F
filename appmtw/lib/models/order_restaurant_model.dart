class OrderRestaurantM {
  int id;
  int productId;
  String name;
  String details;
  String images;
  String enddate;
  String statuspay;
  String orderdate;

  OrderRestaurantM({
    required this.id,
    required this.productId,
    required this.name,
    required this.details,
    required this.images,
    required this.enddate,
    required this.statuspay,
    required this.orderdate,
  });

  factory OrderRestaurantM.fromJson(Map<String, dynamic> json) {
    return OrderRestaurantM(
      id: json['v_id'] ?? '',
      name: json['name'] ?? '',
      productId: json['product'] ?? '',
      details: json['details'] ?? '',
      images: json['images'] ?? '',
      enddate: json['dateend'] ?? '',
      statuspay: json['status_pay'] ?? '',
      orderdate: json['o_created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> datares = new Map<String, dynamic>();
    datares['v_id'] = this.id;
    datares['product'] = this.productId;
    datares['name'] = this.name;
    datares['details'] = this.details;
    datares['images'] = this.images;
    datares['dateend'] = this.enddate;
    datares['status_pay'] = this.statuspay;
    datares['o_created_at'] = this.orderdate;
    return datares;
  }
}
