part of payment;

class HandleDwollaWithdrawUseCase
    extends FutureUseCase<void, HandleDwollaWithdrawPayload> {
  final PaymentRepository _paymentRepository;

  HandleDwollaWithdrawUseCase({
    required PaymentRepository paymentRepository,
  }) : _paymentRepository = paymentRepository;

  @override
  Future<void> execute(HandleDwollaWithdrawPayload params) async {
    return _paymentRepository.handleDwollaWithdraw(params);
  }
}
