class Main {
  int id;
  String photo;

  Main({required this.id, required this.photo});

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      id: json['id'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['photo'] = this.photo;
    return data;
  }
}
