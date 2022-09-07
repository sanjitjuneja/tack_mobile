part of payment_entities;

@JsonSerializable(createToJson: false)
class FeeDataEntity extends JsonSerializable {
  @JsonKey(name: 'fee_percent')
  final double feePercent;
  @JsonKey(name: 'fee_min')
  final int feeMin;
  @JsonKey(name: 'fee_max')
  final int feeMax;

  const FeeDataEntity({
    required this.feePercent,
    required this.feeMin,
    required this.feeMax,
  });

  factory FeeDataEntity.fromJson(Map<String, dynamic> json) {
    return _$FeeDataEntityFromJson(json);
  }
}
