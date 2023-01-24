class VouchersRes {
  int id;
  String name;
  String details;
  String images;
  int unit_price;
  int discount;

  VouchersRes({
    required this.id,
    required this.name,
    required this.details,
    required this.images,
    required this.unit_price,
    required this.discount,
  });

  factory VouchersRes.fromJson(Map<String, dynamic> json) {
    return VouchersRes(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      details: json['details'] ?? '',
      unit_price: json['unit_price'] ?? 0,
      discount: json['purchase_price'],
      images: json['images'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> datares = new Map<String, dynamic>();
    datares['id'] = this.id;
    datares['name'] = this.name;
    datares['details'] = this.details;
    datares['unit_price'] = this.unit_price;
    datares['images'] = this.images;
    datares['purchase_price'] = this.discount;
    return datares;
  }
}
