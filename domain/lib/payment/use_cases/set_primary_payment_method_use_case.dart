part of payment;

class SetPrimaryPaymentMethodUseCase
    extends FutureUseCase<void, SetPrimaryPaymentMethodPayload> {
  final PaymentRepository _paymentRepository;

  SetPrimaryPaymentMethodUseCase({
    required PaymentRepository paymentRepository,
  }) : _paymentRepository = paymentRepository;

  @override
  Future<void> execute(
    SetPrimaryPaymentMethodPayload params,
  ) async {
    await _paymentRepository.setPrimaryPaymentMethod(params);
  }
}
