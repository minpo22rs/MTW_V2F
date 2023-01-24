class AddressM {
  int id;
  String name;
  String phone;
  String province;
  String district;
  String subdistrict;
  int postcode;
  String detail;
  String mdf;

  AddressM({
    required this.id,
    required this.name,
    required this.phone,
    required this.province,
    required this.district,
    required this.subdistrict,
    required this.postcode,
    required this.detail,
    required this.mdf,
  });

  factory AddressM.fromJson(Map<String, dynamic> json) {
    return AddressM(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      province: json['province'],
      district: json['district'],
      subdistrict: json['subdistrict'],
      postcode: json['postcode'],
      detail: json['detail'],
      mdf: json['default'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['province'] = this.province;
    data['district'] = this.district;
    data['subdistrict'] = this.subdistrict;
    data['postcode'] = this.postcode;
    data['detail'] = this.detail;
    data['default'] = this.mdf;
    return data;
  }
}
