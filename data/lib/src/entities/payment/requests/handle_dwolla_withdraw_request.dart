part of payment_entities;

@JsonSerializable(createFactory: false)
class HandleDwollaWithdrawRequest extends JsonSerializable {
  @JsonKey(name: 'payment_method')
  final String? paymentMethodId;
  @JsonKey(name: 'amount')
  final double amountInCents;
  @JsonKey(name: 'currency')
  final String currency;

  const HandleDwollaWithdrawRequest({
    required this.paymentMethodId,
    required this.amountInCents,
    required this.currency,
  });

  @override
  Map<String, dynamic> toJson() => _$HandleDwollaWithdrawRequestToJson(this);
}
