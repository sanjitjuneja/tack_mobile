part of session_entity;

@JsonSerializable(createFactory: false)
class StartSessionRequest extends JsonSerializable {
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  final String password;
  @JsonKey(name: 'firebase_token')
  final String? firebaseToken;
  @JsonKey(name: 'device_id')
  final String? deviceId;
  @JsonKey(name: 'device_name')
  final String? deviceName;
  @JsonKey(name: 'device_type')
  final String deviceType;

  const StartSessionRequest({
    required this.phoneNumber,
    required this.password,
    required this.firebaseToken,
    required this.deviceId,
    required this.deviceType,
    required this.deviceName,
  });

  @override
  Map<String, dynamic> toJson() => _$StartSessionRequestToJson(this);
}
