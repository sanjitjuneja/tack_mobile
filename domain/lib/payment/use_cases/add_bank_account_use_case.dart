part of payment;

class AddBankAccountUseCase
    extends FutureUseCase<List<ConnectedBankAccount>?, AddBankAccountPayload> {
  final PaymentRepository _paymentRepository;

  AddBankAccountUseCase({
    required PaymentRepository paymentRepository,
  }) : _paymentRepository = paymentRepository;

  @override
  Future<List<ConnectedBankAccount>?> execute(AddBankAccountPayload params) async {
    return _paymentRepository.addBankAccount(params);
  }
}
