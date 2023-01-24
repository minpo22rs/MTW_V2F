class Restaurant {
  int id;
  String name;
  String address;
  String rating;
  String image;
  String description;
  String location;

  Restaurant({
    required this.id,
    required this.name,
    required this.address,
    required this.rating,
    required this.image,
    required this.description,
    required this.location,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] ?? '',
      name: json['shopname'] ?? '',
      address: json['address'] ?? '',
      rating: json['rating'],
      description: json['short_detail'] ?? '',
      location: json['position_url'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> datares = new Map<String, dynamic>();
    datares['id'] = this.id;
    datares['shopname'] = this.name;
    datares['address'] = this.address;
    datares['rating'] = this.rating;
    datares['short_detail'] = this.description;
    datares['image'] = this.image;
    datares['position_url'] = this.location;
    return datares;
  }
}
