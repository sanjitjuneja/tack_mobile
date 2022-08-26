class PhoneData {
  final bool Function(String) validator;
  final String Function(String) fieldAdjuster;
  final bool hasError;
  final String phone;

  String get formattedData => fieldAdjuster(phone);

  get isValid => validator(phone);

  const PhoneData({
    required this.validator,
    required this.fieldAdjuster,
    this.hasError = false,
    this.phone = '',
  });

  PhoneData copyWith({
    String? phone,
  }) {
    return PhoneData(
      validator: validator,
      fieldAdjuster: fieldAdjuster,
      phone: phone ?? this.phone,
    );
  }
}
