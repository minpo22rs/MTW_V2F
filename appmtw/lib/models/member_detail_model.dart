class MemberDetail {
  int id;
  String m_id;
  String fname;
  String lname;
  String image;
  int rating;
  String city;
  String link;
  String birth;
  int height;
  int weight;
  String proportion;
  String skill;
  String educate;
  String interest;
  String detail;

  MemberDetail(
      {required this.id,
      required this.m_id,
      required this.fname,
      required this.lname,
      required this.image,
      required this.rating,
      required this.city,
      required this.link,
      required this.birth,
      required this.height,
      required this.weight,
      required this.proportion,
      required this.skill,
      required this.educate,
      required this.interest,
      required this.detail});

  factory MemberDetail.fromJson(Map<String, dynamic> json) {
    return MemberDetail(
      id: json['id'],
      m_id: json['number'] ?? '',
      fname: json['f_name'],
      lname: json['l_name'],
      image: json['image'],
      rating: json['rating'],
      city: json['name_th'] ?? '',
      link: json['link_video'] ?? '',
      birth: json['birth'] ?? '',
      height: json['height'] ?? '',
      weight: json['weight'] ?? '',
      proportion: json['proportion'] ?? '',
      skill: json['skill'] ?? '',
      educate: json['education'] ?? '',
      interest: json['interest'] ?? '',
      detail: json['detail'] ?? '',
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
    data['link_video'] = this.link;
    data['birth'] = this.birth;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['proportion'] = this.proportion;
    data['skill'] = this.skill;
    data['education'] = this.educate;
    data['interest'] = this.interest;
    data['detail'] = this.detail;
    return data;
  }
}
