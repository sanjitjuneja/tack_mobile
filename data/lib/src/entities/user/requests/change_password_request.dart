part of user_entities;

@JsonSerializable(createFactory: false)
class ChangePasswordRequest extends JsonSerializable {
  @JsonKey(name: 'old_password')
  final String oldPassword;
  @JsonKey(name: 'new_password')
  final String newPassword;

  const ChangePasswordRequest({
    required this.oldPassword,
    required this.newPassword,
  });

  @override
  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);
}
