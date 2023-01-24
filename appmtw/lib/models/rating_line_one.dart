class RatingLineone {
  int id;
  int no_row;
  String fname;
  String lname;
  String image;
  int rating;
  String city;

  RatingLineone({
    required this.id,
    required this.no_row,
    required this.fname,
    required this.lname,
    required this.image,
    required this.rating,
    required this.city,
  });

  factory RatingLineone.fromJson(Map<String, dynamic> json) {
    return RatingLineone(
      id: json['id'],
      no_row: json['no_row'],
      fname: json['f_name'],
      lname: json['l_name'],
      image: json['image'],
      rating: json['rating'],
      city: json['city'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['no_row'] = this.no_row;
    data['f_name'] = this.fname;
    data['l_name'] = this.lname;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['city'] = this.city;
    return data;
  }
}
