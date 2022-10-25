part of mappers;

class PaymentSetupIntentMapper
    implements Mapper<PaymentSetupIntentEntity, domain.PaymentSetupIntent> {
  const PaymentSetupIntentMapper();

  @override
  domain.PaymentSetupIntent fromEntity(PaymentSetupIntentEntity entity) {
    return domain.PaymentSetupIntent(
      transactionId: entity.transactionId,
      clientSecret: entity.clientSecret,
    );
  }

  @override
  PaymentSetupIntentEntity toEntity(domain.PaymentSetupIntent item) {
    return PaymentSetupIntentEntity(
      transactionId: item.transactionId,
      clientSecret: item.clientSecret,
    );
  }
}
