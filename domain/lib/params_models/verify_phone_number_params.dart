class VerifyPhoneNumberParams {
  final String uuid;
  final String smsCode;

  VerifyPhoneNumberParams({
    required this.uuid,
    required this.smsCode,
  });

  factory VerifyPhoneNumberParams.fromMap(Map<String, dynamic> map) {
    return VerifyPhoneNumberParams(
      uuid: map['uuid'] as String,
      smsCode: map['sms_code'] as String,
    );
  }
}

extension VerifyPhoneNumberParamsExt on VerifyPhoneNumberParams {
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'sms_code': smsCode,
    };
  }
}
