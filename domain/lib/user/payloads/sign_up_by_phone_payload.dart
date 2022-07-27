part of user;

class SignUpByPhonePayload {
  final String uuid;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;

  SignUpByPhonePayload({
    required this.uuid,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });
}
