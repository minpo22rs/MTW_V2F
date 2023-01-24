class ReviewM {
  int id;
  int user;
  String name;
  String image;
  String description;

  ReviewM({
    required this.id,
    required this.user,
    required this.name,
    required this.image,
    required this.description,
  });

  factory ReviewM.fromJson(Map<String, dynamic> json) {
    return ReviewM(
      id: json['id'] ?? '',
      user: json['user'],
      name: json['name'] ?? '',
      description: json['comment'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> datares = new Map<String, dynamic>();
    datares['id'] = this.id;
    datares['user'] = this.user;
    datares['name'] = this.name;
    datares['comment'] = this.description;
    datares['image'] = this.image;
    return datares;
  }
}
