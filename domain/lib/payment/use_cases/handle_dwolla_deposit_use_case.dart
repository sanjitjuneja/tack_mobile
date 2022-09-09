part of payment;

class HandleDwollaDepositUseCase
    extends FutureUseCase<void, HandleDwollaDepositPayload> {
  final PaymentRepository _paymentRepository;

  HandleDwollaDepositUseCase({
    required PaymentRepository paymentRepository,
  }) : _paymentRepository = paymentRepository;

  @override
  Future<void> execute(HandleDwollaDepositPayload params) async {
    return _paymentRepository.handleDwollaDeposit(params);
  }
}
