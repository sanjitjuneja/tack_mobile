part of payment;

class FetchIsApplePaySupportedUseCase
    extends FutureUseCase<bool, FetchIsApplePaySupportedPayload> {
  final PaymentRepository _paymentRepository;

  FetchIsApplePaySupportedUseCase({
    required PaymentRepository paymentRepository,
  }) : _paymentRepository = paymentRepository;

  @override
  Future<bool> execute(
    FetchIsApplePaySupportedPayload params,
  ) async {
    return _paymentRepository.fetchIsApplePaySupported(params);
  }
}
