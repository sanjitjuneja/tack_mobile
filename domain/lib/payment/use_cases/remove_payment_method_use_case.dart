part of payment;

class RemovePaymentMethodUseCase
    extends FutureUseCase<void, RemovePaymentMethodPayload> {
  final PaymentRepository _paymentRepository;

  RemovePaymentMethodUseCase({
    required PaymentRepository paymentRepository,
  }) : _paymentRepository = paymentRepository;

  @override
  Future<void> execute(
    RemovePaymentMethodPayload params,
  ) async {
    await _paymentRepository.removePaymentMethod(params);
  }
}
