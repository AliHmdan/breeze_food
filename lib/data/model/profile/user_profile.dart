class UserProfile {
  final int id;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? avatar; // a1, a2, a3 ...

  UserProfile({
    required this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.avatar,
  });

  UserProfile copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? phone,
    String? avatar,
  }) {
    return UserProfile(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> j) => UserProfile(
        id: j['id'] as int,
        firstName: j['first_name'] as String?,
        lastName: j['last_name'] as String?,
        phone: j['phone'] as String?,
        avatar: j['avatar'] as String?, // <-- مهم
      );

  /// البيانات التي نرسلها للتحديث
  Map<String, dynamic> toUpdateJson() => {
        if (firstName != null) 'first_name': firstName,
        if (lastName != null) 'last_name': lastName,
        if (phone != null) 'phone': phone,
        if (avatar != null) 'avatar': avatar, // <-- مهم
      };
}
