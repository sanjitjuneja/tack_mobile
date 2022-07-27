part of phone_verification_entities;

@JsonSerializable(createFactory: false)
class VerifyPhoneNumberRequest extends JsonSerializable {
  final String uuid;
  @JsonKey(name: 'sms_code')
  final String smsCode;

  const VerifyPhoneNumberRequest({
    required this.uuid,
    required this.smsCode,
  });

  @override
  Map<String, dynamic> toJson() => _$VerifyPhoneNumberRequestToJson(this);
}
