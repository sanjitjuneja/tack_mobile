part of payment_entities;

@JsonSerializable(createFactory: false)
class RemovePaymentMethodRequest extends JsonSerializable {
  @JsonKey(name: 'payment_type')
  final String paymentType;
  @JsonKey(name: 'payment_method')
  final String paymentMethodId;

  const RemovePaymentMethodRequest({
    required this.paymentType,
    required this.paymentMethodId,
  });

  @override
  Map<String, dynamic> toJson() => _$RemovePaymentMethodRequestToJson(this);
}