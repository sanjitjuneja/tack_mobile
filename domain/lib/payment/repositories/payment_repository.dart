part of payment;

abstract class PaymentRepository {
  Future<SetupIntent> addCard(AddCardPayload payload);
  Future<List<BankAccount>?> addBankAccount(AddBankAccountPayload payload);
}
