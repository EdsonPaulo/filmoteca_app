class UserModel {
  String uid;
  String name;
  String email;
  String? photoUrl;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': name,
      'photoUrl': photoUrl,
    };
  }
}
