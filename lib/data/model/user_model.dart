class UserModel {
  final int id;
  final String? name;
  final String? email;
  final String phone;
  final String? type;
  final String? status;
  final String? profileImage;
  final String? referralCode;

  UserModel({
    required this.id,
    this.name,
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
      name: json['name'],
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
    "name": name,
    "email": email,
    "phone": phone,
    "type": type,
    "status": status,
    "profile_image": profileImage,
    "referral_code": referralCode,
  };
}
