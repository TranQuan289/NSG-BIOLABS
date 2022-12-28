class ProfileModel {
  ProfileModel({
    this.id,
    this.fullName,
    this.email,
    this.role,
    this.countryCode,
    this.phoneNumber,
    this.phoneNumberNormalized,
    this.avatar,
    this.company,
  });

  int? id;
  String? fullName;
  String? email;
  String? role;
  String? countryCode;
  String? phoneNumber;
  String? phoneNumberNormalized;
  String? avatar;
  Company? company;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json['id'],
        fullName: json['full_name'],
        email: json['email'],
        role: json['role'],
        countryCode: json['country_code'],
        phoneNumber: json['phone_number'],
        phoneNumberNormalized: json['phone_number_normalized'],
        avatar: json['avatar'],
        company: Company.fromJson(json['company']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'full_name': fullName,
        'email': email,
        'role': role,
        'country_code': countryCode,
        'phone_number': phoneNumber,
        'phone_number_normalized': phoneNumberNormalized,
        'avatar': avatar,
        'company': company!.toJson(),
      };
}

class Company {
  Company({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
