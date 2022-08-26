part of payment;

class GetConnectedBankAccountsUseCase extends FutureUseCase<
    List<ConnectedBankAccount>, GetConnectedBankAccountsPayload> {
  final PaymentRepository _paymentRepository;

  GetConnectedBankAccountsUseCase({
    required PaymentRepository paymentRepository,
  }) : _paymentRepository = paymentRepository;

  @override
  Future<List<ConnectedBankAccount>> execute(
    GetConnectedBankAccountsPayload params,
  ) async {
    return _paymentRepository.getConnectedBankAccounts(params);
  }
}
