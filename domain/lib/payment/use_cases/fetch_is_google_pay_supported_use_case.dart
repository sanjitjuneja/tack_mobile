part of payment;

class FetchIsGooglePaySupportedUseCase
    extends FutureUseCase<bool, FetchIsGooglePaySupportedPayload> {
  final PaymentRepository _paymentRepository;

  FetchIsGooglePaySupportedUseCase({
    required PaymentRepository paymentRepository,
  }) : _paymentRepository = paymentRepository;

  @override
  Future<bool> execute(
    FetchIsGooglePaySupportedPayload params,
  ) async {
    return _paymentRepository.fetchIsGooglePaySupported(params);
  }
}
