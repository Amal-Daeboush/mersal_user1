class User1Model {
  int? id;
  String? phone;
  String? phoneVerifiedAt;
  String? city;

  User1Model({this.id, this.phone, this.phoneVerifiedAt, this.city});

  User1Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    phoneVerifiedAt = json['phone_verified_at'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phone'] = phone;
    data['phone_verified_at'] = phoneVerifiedAt;
    data['city'] = city;
    return data;
  }
}
