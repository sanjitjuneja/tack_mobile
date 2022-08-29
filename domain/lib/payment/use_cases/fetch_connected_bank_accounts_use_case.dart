part of payment;

class FetchConnectedBankAccountsUseCase extends FutureUseCase<
    List<ConnectedBankAccount>, FetchConnectedBankAccountsPayload> {
  final PaymentRepository _paymentRepository;

  FetchConnectedBankAccountsUseCase({
    required PaymentRepository paymentRepository,
  }) : _paymentRepository = paymentRepository;

  @override
  Future<List<ConnectedBankAccount>> execute(
    FetchConnectedBankAccountsPayload params,
  ) async {
    return _paymentRepository.fetchConnectedBankAccounts(params);
  }
}
