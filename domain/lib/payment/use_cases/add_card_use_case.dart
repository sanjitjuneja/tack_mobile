part of payment;

class AddCardUseCase extends FutureUseCase<SetupIntent, AddCardPayload> {
  final PaymentRepository _paymentRepository;

  AddCardUseCase({
    required PaymentRepository paymentRepository,
  }) : _paymentRepository = paymentRepository;

  @override
  Future<SetupIntent> execute(AddCardPayload params) async {
    return _paymentRepository.addCard(params);
  }
}
