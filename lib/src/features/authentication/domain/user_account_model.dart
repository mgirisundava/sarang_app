import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserAccountModel {
  final String fullname;
  final String email;
  final String password;
  final String occupation;
  final String age;
  String? image;
  String? bio;

  UserAccountModel({
    required this.fullname,
    required this.email,
    required this.password,
    required this.occupation,
    required this.age,
    this.image,
    this.bio,
  });

  @override
  String toString() {
    return 'UserAccountModel(fullname: $fullname, email: $email, password: $password, occupation: $occupation, age: $age, image: $image, bio: $bio)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullname': fullname,
      'email': email,
      'password': password,
      'occupation': occupation,
      'age': age,
      'image': image,
      'bio': bio,
    };
  }

  factory UserAccountModel.fromMap(Map<String, dynamic> map) {
    return UserAccountModel(
      fullname: map['fullname'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      occupation: map['occupation'] as String,
      age: map['age'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      bio: map['bio'] != null ? map['bio'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAccountModel.fromJson(String source) =>
      UserAccountModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant UserAccountModel other) {
    if (identical(this, other)) return true;

    return other.fullname == fullname &&
        other.email == email &&
        other.password == password &&
        other.occupation == occupation &&
        other.age == age &&
        other.image == image &&
        other.bio == bio;
  }

  @override
  int get hashCode {
    return fullname.hashCode ^
        email.hashCode ^
        password.hashCode ^
        occupation.hashCode ^
        age.hashCode ^
        image.hashCode ^
        bio.hashCode;
  }
}
