class UserModel {
  final int id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String phone;
  final String? type;
  final String? status;
  final String? profileImage;
  final String? referralCode;

  UserModel({
    required this.id,
    this.firstName,
    this.lastName,
    this.email,
    required this.phone,
    this.type,
    this.status,
    this.profileImage,
    this.referralCode,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      type: json['type'],
      status: json['status'],
      profileImage: json['profile_image'],
      referralCode: json['referral_code'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
    "type": type,
    "status": status,
    "profile_image": profileImage,
    "referral_code": referralCode,
  };
}
