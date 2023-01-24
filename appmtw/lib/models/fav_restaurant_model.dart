class RestaurantFav {
  int id;
  String name;
  String rating;
  String image;
  String description;
  String location;

  RestaurantFav({
    required this.id,
    required this.name,
    required this.rating,
    required this.image,
    required this.description,
    required this.location,
  });

  factory RestaurantFav.fromJson(Map<String, dynamic> json) {
    return RestaurantFav(
      id: json['id'] ?? '',
      name: json['shopname'] ?? '',
      rating: json['rating'] ?? '',
      description: json['short_detail'] ?? '',
      location: json['position_url'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> datares = new Map<String, dynamic>();
    datares['location_id'] = this.id;
    datares['shopname'] = this.name;
    datares['rating'] = this.rating;
    datares['short_detail'] = this.description;
    datares['image'] = this.image;
    datares['position_url'] = this.location;
    return datares;
  }
}
