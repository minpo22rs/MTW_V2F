class Sellerimg {
  int id;
  String img;

  Sellerimg({
    required this.id,
    required this.img,
  });

  factory Sellerimg.fromJson(Map<String, dynamic> json) {
    return Sellerimg(
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
