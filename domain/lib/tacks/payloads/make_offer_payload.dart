part of tacks;

class MakeOfferPayload extends Equatable {
  final int tackId;
  final int? price;

  MakeOfferPayload({
    required this.tackId,
    double? price,
  }) : price = price == null ? null : (price * 100).toInt();

  @override
  List<Object?> get props => <Object?>[
        tackId,
        price,
      ];
}
