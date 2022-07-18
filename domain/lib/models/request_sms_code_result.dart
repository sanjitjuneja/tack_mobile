class RequestSmsCodeResult {
  final String uuid;

  RequestSmsCodeResult({
    required this.uuid,
  });

  factory RequestSmsCodeResult.fromMap(Map<String, dynamic> map) {
    return RequestSmsCodeResult(
      uuid: map['uuid'],
    );
  }
}
