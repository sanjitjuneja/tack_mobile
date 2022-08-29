part of payment;

abstract class PaymentRepository {
  Future<SetupIntent> addCard(
    AddCardPayload payload,
  );

  Future<List<ConnectedBankAccount>?> addBankAccount(
    AddBankAccountPayload payload,
  );

  Future<List<ConnectedBankAccount>> fetchConnectedBankAccounts(
    FetchConnectedBankAccountsPayload payload,
  );

  Future<List<ConnectedCard>> fetchConnectedCards(
    FetchConnectedCardsPayload payload,
  );

  Future<bool> fetchIsGooglePaySupported(
    FetchIsGooglePaySupportedPayload payload,
  );

  bool fetchIsApplePaySupported(
    FetchIsApplePaySupportedPayload payload,
  );
}
