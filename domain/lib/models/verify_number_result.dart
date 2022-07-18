class VerifyNumberResult {
  final String uuid;
  final String smsCode;

  VerifyNumberResult({
    required this.uuid,
    required this.smsCode,
  });

  factory VerifyNumberResult.fromMap(Map<String, dynamic> map) {
    return VerifyNumberResult(
      uuid: map['uuid'] as String,
      smsCode: map['sms_code'] as String,
    );
  }
}
