// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String fullName;
  final String age;
  final String occupation;
  final String bio;
  final String? imagePath;
  List<String?>? listImage;

  UserModel({
    required this.fullName,
    required this.age,
    required this.occupation,
    required this.bio,
    this.imagePath,
    this.listImage,
  });
}
