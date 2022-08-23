part of user_entities;

@JsonSerializable(createFactory: false)
class RecoveryChangePasswordRequest extends JsonSerializable {
  final String uuid;
  @JsonKey(name: 'new_password')
  final String newPassword;

  const RecoveryChangePasswordRequest({
    required this.uuid,
    required this.newPassword,
  });

  @override
  Map<String, dynamic> toJson() => _$RecoveryChangePasswordRequestToJson(this);
}
