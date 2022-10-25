part of payment;

class HandleStripeDepositUseCase
    extends FutureUseCase<PaymentDetails, HandleStripeDepositPayload> {
  final PaymentRepository _paymentRepository;

  HandleStripeDepositUseCase({
    required PaymentRepository paymentRepository,
  }) : _paymentRepository = paymentRepository;

  @override
  Future<PaymentDetails> execute(HandleStripeDepositPayload params) async {
    return _paymentRepository.handleStripeDeposit(params);
  }
}
