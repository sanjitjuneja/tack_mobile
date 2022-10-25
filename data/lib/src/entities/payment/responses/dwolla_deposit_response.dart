part of payment_entities;

@JsonSerializable(createToJson: false)
class DwollaDepositResponse extends JsonSerializable {
  @JsonKey(name: 'id')
  final String transactionId;

  const DwollaDepositResponse({
    required this.transactionId,
  });

  factory DwollaDepositResponse.fromJson(Map<String, dynamic> json) {
    return _$DwollaDepositResponseFromJson(json);
  }
}
