part of payment;

class GetConnectedCardsUseCase
    extends FutureUseCase<List<ConnectedCard>, GetConnectedCardsPayload> {
  final PaymentRepository _paymentRepository;

  GetConnectedCardsUseCase({
    required PaymentRepository paymentRepository,
  }) : _paymentRepository = paymentRepository;

  @override
  Future<List<ConnectedCard>> execute(
    GetConnectedCardsPayload params,
  ) async {
    return _paymentRepository.getConnectedCards(params);
  }
}
