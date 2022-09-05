part of payment_entities;

@JsonSerializable(createFactory: false)
class SetPrimaryPaymentMethodRequest extends JsonSerializable {
  @JsonKey(name: 'payment_type')
  final String paymentType;
  @JsonKey(name: 'payment_method')
  final String paymentMethodId;

  const SetPrimaryPaymentMethodRequest({
    required this.paymentType,
    required this.paymentMethodId,
  });

  @override
  Map<String, dynamic> toJson() => _$SetPrimaryPaymentMethodRequestToJson(this);
}
