part of payment;

class AddBankAccountUseCase
    extends FutureUseCase<List<BankAccount>?, AddBankAccountPayload> {
  final PaymentRepository _paymentRepository;

  AddBankAccountUseCase({
    required PaymentRepository paymentRepository,
  }) : _paymentRepository = paymentRepository;

  @override
  Future<List<BankAccount>?> execute(AddBankAccountPayload params) async {
    return _paymentRepository.addBankAccount(params);
  }
}
