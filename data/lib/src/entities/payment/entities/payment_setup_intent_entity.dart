part of payment_entities;

@JsonSerializable(createToJson: false)
class PaymentSetupIntentEntity extends JsonSerializable {
  @JsonKey(name: 'client_secret')
  final String clientSecret;

  const PaymentSetupIntentEntity({
    required this.clientSecret,
  });

  factory PaymentSetupIntentEntity.fromJson(Map<String, dynamic> json) {
    return _$PaymentSetupIntentEntityFromJson(json);
  }
}
