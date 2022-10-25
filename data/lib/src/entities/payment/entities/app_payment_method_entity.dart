part of payment_entities;

enum AppPaymentMethodEntity {
  @JsonValue('tack_balance')
  tackBalance,
  @JsonValue('stripe')
  stripe,
  @JsonValue('dwolla')
  dwolla,
}
