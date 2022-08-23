part of payment;

class AddCardUseCase extends FutureUseCase<void, NoParams> {
  final PaymentRepository _paymentRepository;

  AddCardUseCase({
    required PaymentRepository paymentRepository,
  }) : _paymentRepository = paymentRepository;

  @override
  Future<SetupIntent> execute(NoParams params) async {
    return _paymentRepository.addCard();
  }
}
