class Provinces {
  int id;
  String name;

  Provinces({required this.id, required this.name});

  factory Provinces.fromJson(Map<String, dynamic> json) {
    return Provinces(id: json['id'], name: json['name_th']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_th'] = this.name;
    return data;
  }
}
