part of tacks;

class GroupTack extends Equatable with IdentifiableMixin {
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

  @override
  int get itemId => id;
}
