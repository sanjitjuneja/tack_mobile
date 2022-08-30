part of phone_verification_entities;

@JsonSerializable()
class SmsVerificationEntity extends JsonSerializable {
  final String uuid;

  const SmsVerificationEntity({
    required this.uuid,
  });

  factory SmsVerificationEntity.fromJson(Map<String, dynamic> json) {
    return _$SmsVerificationEntityFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$SmsVerificationEntityToJson(this);
}
