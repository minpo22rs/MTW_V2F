class HotRS {
  String id;

  HotRS({
    required this.id,
  });

  factory HotRS.fromJson(Map<String, dynamic> json) {
    return HotRS(
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
