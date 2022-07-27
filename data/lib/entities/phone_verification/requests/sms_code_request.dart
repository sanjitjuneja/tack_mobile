part of phone_verification_entities;

@JsonSerializable(createFactory: false)
class SmsCodeRequest extends JsonSerializable {
  @JsonKey(name: 'phone_number')
  final String phoneNumber;

  const SmsCodeRequest({
    required this.phoneNumber,
  });

  @override
  Map<String, dynamic> toJson() => _$SmsCodeRequestToJson(this);
}
