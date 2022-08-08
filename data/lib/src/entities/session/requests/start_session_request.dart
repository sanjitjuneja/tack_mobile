part of session_entity;

@JsonSerializable(createFactory: false)
class StartSessionRequest extends JsonSerializable {
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  final String password;

  const StartSessionRequest({
    required this.phoneNumber,
    required this.password,
  });

  @override
  Map<String, dynamic> toJson() => _$StartSessionRequestToJson(this);
}
