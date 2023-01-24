class Member {
  int id;
  String m_id;
  String fname;
  String lname;
  String image;
  int rating;
  String city;

  Member({
    required this.id,
    required this.m_id,
    required this.fname,
    required this.lname,
    required this.image,
    required this.rating,
    required this.city,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      m_id: json['number'] ?? '',
      fname: json['f_name'],
      lname: json['l_name'],
      image: json['image'],
      rating: json['rating'],
      city: json['name_th'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number'] = this.m_id;
    data['f_name'] = this.fname;
    data['l_name'] = this.lname;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['name_th'] = this.city;
    return data;
  }
}
