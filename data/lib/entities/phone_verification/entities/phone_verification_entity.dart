part of phone_verification_entities;

@JsonSerializable()
class PhoneVerificationEntity extends JsonSerializable {
  final String message;

  const PhoneVerificationEntity({
    required this.message,
  });

  factory PhoneVerificationEntity.fromJson(Map<String, dynamic> json) {
    return _$PhoneVerificationEntityFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$PhoneVerificationEntityToJson(this);
}
