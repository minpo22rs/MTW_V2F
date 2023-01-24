class RoomsChoose {
  int id;
  String name;
  String cancellation;
  int person;
  int bed;
  int size;
  String detail;
  int purchase_price;
  int unit_price;
  String prepaid;
  String images;

  RoomsChoose({
    required this.id,
    required this.name,
    required this.cancellation,
    required this.person,
    required this.bed,
    required this.size,
    required this.detail,
    required this.purchase_price,
    required this.unit_price,
    required this.prepaid,
    required this.images,
  });

  factory RoomsChoose.fromJson(Map<String, dynamic> json) {
    return RoomsChoose(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      cancellation: json['cancellation_condition'] ?? '',
      person: json['person'] ?? '',
      bed: json['bed'] ?? '',
      size: json['quant_room_for_mtwa'],
      detail: json['details'] ?? '',
      purchase_price: json['purchase_price'] ?? '',
      unit_price: json['unit_price'] ?? 0,
      prepaid: json['prepaid'] ?? '',
      images: json['thumbnail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> datares = new Map<String, dynamic>();
    datares['id'] = this.id;
    datares['name'] = this.name;
    datares['cancellation_condition'] = this.cancellation;
    datares['person'] = this.person;
    datares['bed'] = this.bed;
    datares['quant_room_for_mtwa'] = this.size;
    datares['details'] = this.detail;
    datares['purchase_price'] = this.purchase_price;
    datares['unit_price'] = this.unit_price;
    datares['prepaid'] = this.prepaid;
    datares['thumbnail'] = this.images;
    return datares;
  }
}
