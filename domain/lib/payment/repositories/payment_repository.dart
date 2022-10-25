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

  Future<bool> fetchIsApplePaySupported(
    FetchIsApplePaySupportedPayload payload,
  );

  Future<void> removePaymentMethod(
    RemovePaymentMethodPayload payload,
  );

  Future<void> setPrimaryPaymentMethod(
    SetPrimaryPaymentMethodPayload payload,
  );

  Future<Fee> fetchFee(
    FetchFeePayload payload,
  );

  Future<PaymentDetails> handleDwollaDeposit(
    HandleDwollaDepositPayload payload,
  );

  Future<PaymentDetails> handleStripeDeposit(
    HandleStripeDepositPayload payload,
  );

  Future<void> handleDwollaWithdraw(
    HandleDwollaWithdrawPayload payload,
  );
}
