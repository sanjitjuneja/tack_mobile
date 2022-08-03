part of user;

@JsonSerializable(createFactory: false)
class RegisterUserByPhoneRequest extends JsonSerializable {
  final String uuid;
  final UserRequest user;

  const RegisterUserByPhoneRequest({
    required this.uuid,
    required this.user,
  });

  @override
  Map<String, dynamic> toJson() => _$RegisterUserByPhoneRequestToJson(this);
}
