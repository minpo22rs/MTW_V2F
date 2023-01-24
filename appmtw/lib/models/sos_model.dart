class SosModel {
  int id;
  String name;
  int tel;
  String img;

  SosModel({
    required this.id,
    required this.name,
    required this.tel,
    required this.img,
  });

  factory SosModel.fromJson(Map<String, dynamic> json) {
    return SosModel(
      id: json['id'],
      name: json['name'],
      tel: json['tel'],
      img: json['logo_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['tel'] = this.tel;
    data['logo_url'] = this.img;
    return data;
  }
}
