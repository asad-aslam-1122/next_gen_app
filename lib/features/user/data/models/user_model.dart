
class UserData {
  String name, email;
  String? image;

  UserData({
    required this.name,
    required this.email,
    this.image,
  });
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'image': image,
    };
  }
}
