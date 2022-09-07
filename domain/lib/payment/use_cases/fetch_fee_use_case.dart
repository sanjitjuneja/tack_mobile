part of payment;

class FetchFeeUseCase extends FutureUseCase<Fee, FetchFeePayload> {
  final PaymentRepository _paymentRepository;

  FetchFeeUseCase({
    required PaymentRepository paymentRepository,
  }) : _paymentRepository = paymentRepository;

  @override
  Future<Fee> execute(FetchFeePayload params) async {
    return _paymentRepository.fetchFee(params);
  }
}
