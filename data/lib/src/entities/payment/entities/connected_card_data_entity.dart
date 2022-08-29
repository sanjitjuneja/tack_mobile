part of payment_entities;

@JsonSerializable(createToJson: false)
class ConnectedCardDataEntity extends JsonSerializable {
  @JsonKey(name: 'brand')
  final String brand;
  @JsonKey(name: 'last4')
  final String last4;
  @JsonKey(name: 'exp_year')
  final int expYear;
  @JsonKey(name: 'exp_month')
  final int expMonth;

  const ConnectedCardDataEntity({
    required this.brand,
    required this.last4,
    required this.expYear,
    required this.expMonth,
  });

  factory ConnectedCardDataEntity.fromJson(Map<String, dynamic> json) {
    return _$ConnectedCardDataEntityFromJson(json);
  }
}
