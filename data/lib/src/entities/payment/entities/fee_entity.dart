part of payment_entities;

@JsonSerializable(createToJson: false)
class FeeEntity extends JsonSerializable {
  @JsonKey(name: 'stripe')
  final FeeDataEntity stripeFeeData;
  @JsonKey(name: 'dwolla')
  final FeeDataEntity dwollaFeeData;

  const FeeEntity({
    required this.stripeFeeData,
    required this.dwollaFeeData,
  });

  factory FeeEntity.fromJson(Map<String, dynamic> json) {
    return _$FeeEntityFromJson(json);
  }
}
