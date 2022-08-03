part of user;

@JsonSerializable(createFactory: false)
class SignInRequest extends JsonSerializable {
  final String password;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;

  const SignInRequest({
    required this.password,
    required this.phoneNumber,
  });

  @override
  Map<String, dynamic> toJson() => _$SignInRequestToJson(this);
}
