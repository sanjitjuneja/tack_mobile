class RequestSmsParams {
  final String phoneNumber;

  RequestSmsParams({
    required this.phoneNumber,
  });

  factory RequestSmsParams.fromMap(Map<String, dynamic> map) {
    return RequestSmsParams(
      phoneNumber: map['phone_number'],
    );
  }
}

extension RequestSmsParamsExt on RequestSmsParams {
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phone_number': phoneNumber,
    };
  }
}
