class Attracimg {
  int id;
  String img;

  Attracimg({
    required this.id,
    required this.img,
  });

  factory Attracimg.fromJson(Map<String, dynamic> json) {
    return Attracimg(
      id: json['id'],
      img: json['images'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['images'] = this.img;
    return data;
  }
}
