part of payment;

class FetchConnectedCardsUseCase
    extends FutureUseCase<List<ConnectedCard>, FetchConnectedCardsPayload> {
  final PaymentRepository _paymentRepository;

  FetchConnectedCardsUseCase({
    required PaymentRepository paymentRepository,
  }) : _paymentRepository = paymentRepository;

  @override
  Future<List<ConnectedCard>> execute(
    FetchConnectedCardsPayload params,
  ) async {
    return _paymentRepository.fetchConnectedCards(params);
  }
}
