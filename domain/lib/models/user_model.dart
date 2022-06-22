class UserModel {
  final String name;
  final String imageUrl;

  UserModel({
    required this.name,
    required this.imageUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map[''] as String,
      imageUrl: map[''] as String,
    );
  }
}
