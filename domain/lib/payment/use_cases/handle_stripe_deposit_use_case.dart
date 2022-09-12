part of payment;

class HandleStripeDepositUseCase
    extends FutureUseCase<void, HandleStripeDepositPayload> {
  final PaymentRepository _paymentRepository;

  HandleStripeDepositUseCase({
    required PaymentRepository paymentRepository,
  }) : _paymentRepository = paymentRepository;

  @override
  Future<void> execute(HandleStripeDepositPayload params) async {
    return _paymentRepository.handleStripeDeposit(params);
  }
}
