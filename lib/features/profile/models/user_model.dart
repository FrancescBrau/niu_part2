class UserProfile {
  final String email;
  final String phone;
  final String address;

  UserProfile({
    required this.email,
    required this.phone,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'address': address,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
    );
  }
}
