class User {
  final String username;
  final String password;
  final String phoneNumber;

  User({
    required this.username,
    required this.password,
    required this.phoneNumber,
  });
}

extension UserExt on User {
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
      'phone_number': phoneNumber,
      'first_name': '',
      'last_name': '',
    };
  }
}
