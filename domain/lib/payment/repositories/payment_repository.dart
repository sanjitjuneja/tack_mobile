part of payment;

abstract class PaymentRepository {
  Future<SetupIntent> addCard(AddCardPayload payload);

  Future<List<ConnectedBankAccount>?> addBankAccount(
    AddBankAccountPayload payload,
  );

  Future<List<ConnectedBankAccount>> getConnectedBankAccounts(
    GetConnectedBankAccountsPayload payload,
  );

  Future<List<ConnectedCard>> getConnectedCards(
    GetConnectedCardsPayload payload,
  );
}
