import 'dart:convert';

class UserModel {
  final String id;
  String name;
  String bio;
  String email;
  String avatarUrl;
  String gender;
  final DateTime? birthday;
  String phone;

  UserModel({
    required this.id,
    required this.name,
    required this.bio,
    required this.email,
    required this.avatarUrl,
    required this.gender,
    this.birthday,
    required this.phone,
  });

  // Khởi tạo từ Map (dùng với Firestore hoặc API)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      bio: map['bio'] ?? '',
      email: map['email'] ?? '',
      avatarUrl: map['avatarUrl'] ?? '',
      gender: map['gender'] ?? '',
      birthday: map['birthday'] != null
          ? DateTime.parse(map['birthday'])
          : null,
      phone: map['phone'] ?? '',
    );
  }

  // Convert thành Map (để lưu Firebase/API)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'bio': bio,
      'email': email,
      'avatarUrl': avatarUrl,
      'gender': gender,
      'birthday': birthday?.toIso8601String(),
      'phone': phone,
    };
  }

  // Clone user với giá trị mới
  UserModel copyWith({
    String? name,
    String? bio,
    String? email,
    String? avatarUrl,
    String? gender,
    String? phone,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      phone: phone ?? this.phone,
    );
  }
  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, bio: $bio, email: $email, '
        'avatarUrl: $avatarUrl, gender: $gender, phone: $phone, birthday: $birthday)';
  }
}
