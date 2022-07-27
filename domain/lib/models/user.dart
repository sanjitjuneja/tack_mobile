class User {
  final String firstName;
  final String lastName;
  final String password;
  final String phoneNumber;
  final String confirmedPassword;

  User({
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.phoneNumber,
    required this.confirmedPassword,
  });
}

extension UserExt on User {
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
    };
  }
}
