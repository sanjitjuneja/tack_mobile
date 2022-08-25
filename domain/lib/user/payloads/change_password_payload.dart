part of user;

class ChangePasswordPayload {
  final String oldPassword;
  final String newPassword;

  ChangePasswordPayload({
    required this.oldPassword,
    required this.newPassword,
  });
}
