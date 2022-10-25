part of payment_entities;

@JsonSerializable(
  createFactory: false,
  includeIfNull: false,
  fieldRename: FieldRename.snake,
)
class PaymentDetailsEntity extends JsonSerializable {
  final String? transactionId;
  final AppPaymentMethodEntity methodType;

  const PaymentDetailsEntity({
    required this.transactionId,
    required this.methodType,
  });

  @override
  Map<String, dynamic> toJson() => _$PaymentDetailsEntityToJson(this);
}
