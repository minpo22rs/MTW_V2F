class Proimg {
  int id;
  String img;

  Proimg({
    required this.id,
    required this.img,
  });

  factory Proimg.fromJson(Map<String, dynamic> json) {
    return Proimg(
      id: json['id'],
      img: json['product_images'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_images'] = this.img;
    return data;
  }
}
