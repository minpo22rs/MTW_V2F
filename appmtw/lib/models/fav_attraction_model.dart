class AttractionFav {
  int id;
  String name;
  String rating;
  String image;
  String description;
  String location;

  AttractionFav({
    required this.id,
    required this.name,
    required this.rating,
    required this.image,
    required this.description,
    required this.location,
  });

  factory AttractionFav.fromJson(Map<String, dynamic> json) {
    return AttractionFav(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      rating: json['rating'] ?? '0',
      description: json['short_detail'] ?? '',
      location: json['position_url'] ?? '',
      image: json['img_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataattrac = new Map<String, dynamic>();
    dataattrac['id'] = this.id;
    dataattrac['name'] = this.name;
    dataattrac['rating'] = this.rating;
    dataattrac['short_detail'] = this.description;
    dataattrac['img_url'] = this.image;
    dataattrac['position_url'] = this.location;
    return dataattrac;
  }
}
