class Top3 {
  int id;
  String fname;
  String lname;
  String image;
  int rating;
  String country;

  Top3(
      {required this.id,
      required this.fname,
      required this.lname,
      required this.image,
      required this.rating,
      required this.country});

  factory Top3.fromJson(Map<String, dynamic> json) {
    return Top3(
      id: json['id'],
      fname: json['f_name'],
      lname: json['l_name'],
      image: json['image'],
      rating: json['rating'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['country'] = this.country;
    return data;
  }
}
