part of tacks;

class GroupTack extends Equatable {
  final int id;
  final Tack tack;
  final bool isMineOfferSent;

  const GroupTack({
    required this.id,
    required this.tack,
    required this.isMineOfferSent,
  });

  @override
  List<Object> get props => <Object>[
        id,
        tack,
        isMineOfferSent,
      ];
}
