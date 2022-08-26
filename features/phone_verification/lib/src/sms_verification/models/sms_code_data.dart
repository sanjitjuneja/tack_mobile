class SmsCodeData {
  final bool Function(String) validator;
  final bool hasError;
  final String code;

  get isValid => validator(code);

  const SmsCodeData({
    required this.validator,
    this.hasError = false,
    this.code = '',
  });

  SmsCodeData copyWith({
    String? code,
  }) {
    return SmsCodeData(
      validator: validator,
      code: code ?? this.code,
    );
  }
}
