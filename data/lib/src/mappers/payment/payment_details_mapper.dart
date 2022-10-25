part of mappers;

class PaymentDetailsMapper
    implements Mapper<PaymentDetailsEntity, domain.PaymentDetails> {
  final AppPaymentMethodMapper appPaymentMethodMapper;

  const PaymentDetailsMapper({
    required this.appPaymentMethodMapper,
  });

  @override
  domain.PaymentDetails fromEntity(PaymentDetailsEntity entity) {
    return domain.PaymentDetails(
      paymentTransactionId: entity.transactionId,
      paymentMethod: appPaymentMethodMapper.fromEntity(entity.methodType),
    );
  }

  @override
  PaymentDetailsEntity toEntity(domain.PaymentDetails item) {
    return PaymentDetailsEntity(
      transactionId: item.paymentTransactionId,
      methodType: appPaymentMethodMapper.toEntity(item.paymentMethod),
    );
  }
}
