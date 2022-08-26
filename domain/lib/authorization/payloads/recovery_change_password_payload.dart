part of authorization;

class RecoveryChangePasswordPayload {
  final String uuid;
  final String password;

  const RecoveryChangePasswordPayload({
    required this.uuid,
    required this.password,
  });
}
