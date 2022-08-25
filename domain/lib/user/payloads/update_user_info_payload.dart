part of user;

class UpdateUserInfoPayload {
  final String? firstName;
  final String? lastName;
  final String? email;

  UpdateUserInfoPayload({
    required this.firstName,
    required this.lastName,
    required this.email,
  });
}
