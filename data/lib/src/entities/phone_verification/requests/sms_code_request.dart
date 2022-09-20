part of phone_verification_entities;

@JsonSerializable(createFactory: false)
class SmsCodeRequest extends JsonSerializable {
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @JsonKey(name: 'device_id')
  final String? deviceId;

  const SmsCodeRequest({
    required this.phoneNumber,
    required this.deviceId,
  });

  @override
  Map<String, dynamic> toJson() => _$SmsCodeRequestToJson(this);
}
