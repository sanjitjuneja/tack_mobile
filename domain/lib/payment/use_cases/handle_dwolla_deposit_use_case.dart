part of payment;

class HandleDwollaDepositUseCase
    extends FutureUseCase<PaymentDetails, HandleDwollaDepositPayload> {
  final PaymentRepository _paymentRepository;

  HandleDwollaDepositUseCase({
    required PaymentRepository paymentRepository,
  }) : _paymentRepository = paymentRepository;

  @override
  Future<PaymentDetails> execute(HandleDwollaDepositPayload params) async {
    return _paymentRepository.handleDwollaDeposit(params);
  }
}
