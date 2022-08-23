part of payment;

abstract class PaymentRepository {
  Future<SetupIntent> addCard();
}
