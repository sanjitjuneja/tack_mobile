part of mappers;

class PaymentSetupIntentMapper
    implements Mapper<PaymentSetupIntentEntity, domain.PaymentSetupIntent> {
  const PaymentSetupIntentMapper();

  @override
  domain.PaymentSetupIntent fromEntity(PaymentSetupIntentEntity entity) {
    return domain.PaymentSetupIntent(
      clientSecret: entity.clientSecret,
    );
  }

  @override
  PaymentSetupIntentEntity toEntity(domain.PaymentSetupIntent item) {
    return PaymentSetupIntentEntity(
      clientSecret: item.clientSecret,
    );
  }
}
